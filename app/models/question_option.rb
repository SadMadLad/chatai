# frozen_string_literal: true

# Single option of a quiz
class QuestionOption < ApplicationRecord
  belongs_to :question

  validates :correct, boolean: true
  validates :option_text, presence: true
end
