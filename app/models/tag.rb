# frozen_string_literal: true

# Tags categories associated with different records.
class Tag < ApplicationRecord
  has_many :tag_maps, dependent: :destroy
  has_many :live_chat_rooms, through: :tag_maps, source: :taggable, source_type: 'Chat'
  has_many :quizzes, through: :tag_maps, source: :taggable, source_type: 'Quiz'

  validates :tag, presence: false, uniqueness: true
end
