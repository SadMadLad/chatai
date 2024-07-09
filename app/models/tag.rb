# frozen_string_literal: true

# == Schema Information
#
# Table name: tags
#
#  id         :bigint           not null, primary key
#  tag_type   :integer          default("display"), not null
#  tag        :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Tag < ApplicationRecord
  has_many :tag_maps, dependent: :destroy

  has_many :flash_cards, through: :tag_maps, source: :taggable, source_type: 'FlashCard'
  has_many :live_chat_rooms, through: :tag_maps, source: :taggable, source_type: 'Chat'
  has_many :quizzes, through: :tag_maps, source: :taggable, source_type: 'Quiz'

  validates :tag, presence: false, uniqueness: true
  validates :tag_type, presence: true

  enum :tag_type, { display: 0, meta: 1 }
end
