# frozen_string_literal: true

# Quiz having many questions.
class Quiz < ApplicationRecord
  has_many :questions, dependent: :destroy
  has_many :question_options, through: :questions
  has_many :tags, through: :tag_maps

  has_one_attached :cover

  validates :published, boolean: true
  validates :timer, presence: true, comparison: { greater_than: 60 }, if: :timed?
  validates :timed, boolean: true
  validates :title, :description, presence: true
end
