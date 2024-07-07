# frozen_string_literal: true

# == Schema Information
#
# Table name: quizzes
#
#  id                      :bigint           not null, primary key
#  account_id              :bigint
#  timer                   :integer
#  questions_count         :integer          default(0), not null
#  quiz_undertakings_count :integer          default(0), not null
#  rating_count            :integer          default(0), not null
#  total_score             :integer          default(0), not null
#  total_rating            :integer          default(0), not null
#  title                   :string           not null
#  published               :boolean          default(FALSE), not null
#  timed                   :boolean          default(FALSE), not null
#  description             :text             not null
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#
# Quiz having many questions.
class Quiz < ApplicationRecord
  include SearchBy

  belongs_to :account, optional: true

  has_many :accounts, through: :quiz_undertakings
  has_many :questions, dependent: :destroy
  has_many :question_options, through: :questions
  has_many :quiz_undertakings, dependent: :destroy
  has_many :ratings, as: :rateable, dependent: :destroy
  has_many :tag_maps, as: :taggable, dependent: :destroy
  has_many :tags, through: :tag_maps

  has_one_attached :cover

  validates :published, boolean: true
  validates :timer, presence: true, comparison: { greater_than: 0 }, if: :timed?
  validates :timed, boolean: true
  validates :title, :description, presence: true

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

  class << self
    def search_by_tags
      return all unless any_param_exists? [:tags]

      joins(:tags)
        .where(tags: { tag: @params[:tags] })
        .group(:id)
        .having('COUNT(DISTINCT tags.id) = ?', @params[:tags].length)
    end
  end
end
