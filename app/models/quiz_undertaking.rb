# frozen_string_literal: true

class QuizUndertaking < ApplicationRecord
  belongs_to :account
  belongs_to :quiz

  validates :correct_answers, presence: true, comparison: { greater_than_or_equal_to: 0 }
end
