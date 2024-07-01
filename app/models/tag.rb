# frozen_string_literal: true

# == Schema Information
#
# Table name: tags
#
#  id         :bigint           not null, primary key
#  tag        :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Tags categories associated with different records.
class Tag < ApplicationRecord
  has_many :live_chat_rooms, through: :tag_maps, source: :taggable, source_type: 'Chat'
  has_many :quizzes, through: :tag_maps, source: :taggable, source_type: 'Quiz'
  has_many :tag_maps, dependent: :destroy

  validates :tag, presence: false, uniqueness: true
end
