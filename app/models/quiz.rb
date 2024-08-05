# frozen_string_literal: true

# == Schema Information
#
# Table name: quizzes
#
#  id                      :bigint           not null, primary key
#  account_id              :bigint
#  published               :boolean          default(FALSE), not null
#  timed                   :boolean          default(FALSE), not null
#  collectable_maps_count  :integer          default(0), not null
#  favorites_count         :integer          default(0), not null
#  questions_count         :integer          default(0), not null
#  quiz_undertakings_count :integer          default(0), not null
#  ratings_count           :integer          default(0), not null
#  timer                   :integer
#  total_score             :integer          default(0), not null
#  total_rating            :integer          default(0), not null
#  title                   :string           not null
#  description             :text             not null
#  latest_taken_at         :datetime
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#
class Quiz < ApplicationRecord
  include ActivityLoggable
  include Collectable
  include Embeddable
  include Favoritable
  include SearchBy
  include Taggable

  belongs_to :account, optional: true

  has_many :accounts, through: :quiz_undertakings
  has_many :questions, dependent: :destroy
  has_many :question_options, through: :questions
  has_many :quiz_undertakings, dependent: :destroy
  has_many :ratings, as: :rateable, dependent: :destroy

  has_one_attached :cover

  validates :published, boolean: true
  validates :timed, boolean: true
  validates :timer, presence: true, comparison: { greater_than: 0 }, if: :timed?
  validates :title, :description, presence: true

  before_create -> { @create_log_text = "Created quiz titled: #{title}" }
  before_destroy -> { @destroy_log_text = "Deleted quiz titled: #{title}" }

  embeddable_text columns: %i[title description]

  accepts_nested_attributes_for :questions

  def score_selected_options(selected_options)
    questions_array = questions.includes(:question_options)
    total_score = 0

    selected_options.each do |question_id, selected|
      q = questions_array.find { |question| question.id == question_id }
      total_score += q.score_selected_options(selected)
    end

    total_score
  end
end
