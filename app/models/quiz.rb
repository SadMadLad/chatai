# frozen_string_literal: true

# Quiz having many questions.
class Quiz < ApplicationRecord
  belongs_to :account

  has_many :accounts, through: :quiz_undertakings
  has_many :question_options, through: :questions
  has_many :questions, dependent: :destroy
  has_many :quiz_undertakings, dependent: :destroy
  has_many :tag_maps, as: :taggable, dependent: :destroy
  has_many :tags, through: :tag_maps

  has_one_attached :cover

  validates :published, boolean: true
  validates :timer, presence: true, comparison: { greater_than: 60 }, if: :timed?
  validates :timed, boolean: true
  validates :title, :description, presence: true

  validate :publish_quiz, if: :saved_change_to_published?

  private

  def publish_quiz; end
end
