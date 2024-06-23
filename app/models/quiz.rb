# frozen_string_literal: true

# Quiz having many questions.
class Quiz < ApplicationRecord
  belongs_to :account, optional: true

  has_many :accounts, through: :quiz_undertakings
  has_many :question_options, through: :questions
  has_many :questions, dependent: :destroy
  has_many :quiz_undertakings, dependent: :destroy
  has_many :tag_maps, as: :taggable, dependent: :destroy
  has_many :tags, through: :tag_maps

  has_one_attached :cover

  validates :published, boolean: true
  validates :timer, presence: true, comparison: { greater_than: 0 }, if: :timed?
  validates :timed, boolean: true
  validates :title, :description, presence: true

  accepts_nested_attributes_for :questions

  def score(selected_options)
    questions_array = questions.includes(:question_options)
    total_score = 0

    selected_options.each do |question_id, selected|
      q = questions_array.find{ |question| question.id == question_id }
      total_score += q.score(selected)  
    end

    total_score
  end
end
