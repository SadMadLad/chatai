# frozen_string_literal: true

# A question in a quiz.
class Question < ApplicationRecord
  SCORE_FOR_MULTIPLE_ANSWERS = 2.0

  scope :randomize, -> { order('random()') }

  has_many :question_options, dependent: :destroy

  belongs_to :quiz

  has_one_attached :picture

  validates :multiple_answers, boolean: true

  accepts_nested_attributes_for :question_options

  def score(selected_options)
    correct_options = question_options.select(&:correct?).pluck(:id)

    if multiple_answers
      score_for_multiple_answers(correct_options, selected_options)
    else
      selected_options == correct_options.first ? 1 : 0
    end
  end

  private

  def score_for_multiple_answers(correct_options, selected_options)
    cummulative_score = 0.0
    score_per_correct_answer = SCORE_FOR_MULTIPLE_ANSWERS / correct_options.length

    selected_options.each do |selected_option|
      if correct_options.include?(selected_option)
        cummulative_score += score_per_correct_answer
      else
        cummulative_score -= score_per_correct_answer
      end
    end

    [cummulative_score, 0].max
  end
end
