# frozen_string_literal: true

# A question in a quiz.
class Question < ApplicationRecord
  scope :randomize, -> { order('random()') }

  has_many :question_options, dependent: :destroy

  belongs_to :quiz

  validates :multiple_answers, boolean: true

  has_one_attached :picture
end
