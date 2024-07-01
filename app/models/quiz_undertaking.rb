# frozen_string_literal: true

# An instance of quiz undertaking is the instance of user taking a quiz.
class QuizUndertaking < ApplicationRecord
  belongs_to :account
  belongs_to :quiz

  validates :correct_answers, presence: true, comparison: { greater_than_or_equal_to: 0 }
  validates :
end
