# frozen_string_literal: true

# A question in a quiz.
class Question < ApplicationRecord
  SCORE_FOR_MULTIPLE_ANSWERS = 2.0

  scope :randomize, -> { order('random()') }

  has_many :question_options, dependent: :destroy

  belongs_to :quiz

  has_one_attached :picture

  validates :score, presence: true, comparison: { greather_than: 0, less_than: 100 }
  validates :multiple_answers, boolean: true

  accepts_nested_attributes_for :question_options

  after_commit :increase_quiz_total_score, on: :create
  after_commit :decrease_quiz_total_score, on: :destroy

  def increase_quiz_total_score
    quiz.update_column(:total_score, quiz.total_score + score)
  end

  def decrease_quiz_total_score
    quiz.update_column(:total_score, quiz.total_score - score)
  end

  # The argument selected_options can be singular as well as plural
  def score_selected_options(selected_options)
    correct_options = question_options.select(&:correct?).pluck(:id)

    if multiple_answers
      score_for_multiple_answers(correct_options, selected_options)
    else
      selected_options == correct_options.first ? score : 0
    end
  end

  private

  def score_for_multiple_answers(correct_options, selected_options)
    cummulative_score = 0.0
    score_per_correct_answer = (score / correct_options.length).to_f

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
