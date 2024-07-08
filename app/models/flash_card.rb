# frozen_string_literal: true

# == Schema Information
#
# Table name: flash_cards
#
#  id         :bigint           not null, primary key
#  account_id :bigint
#  style      :integer          default("basic"), not null
#  color      :string           default("#84cc16"), not null
#  answer     :text             not null
#  prompt     :text             not null
#  published  :boolean          default(FALSE), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Color Names
#   rose: #f43f5e, pink: #ec4899, fuchsia: #d946ef, purple: #a855f7, violet: #8b5cf6,
#   indigo: #6366f1, blue: #3b82f6, sky: #0ea5e9, cyan: #06b6d4, teal: #14b8a6,
#   emerald: #10b981, green: #22c55e, lime: #84cc16, yellow: #eab308, amber: #f59e0b,
#   orange: #f97316, red: #ef4444, stone: #78716c, neutral: #737373, zinc: #71717a,
#   gray: #6b7280, slate: #64748b

class FlashCard < ApplicationRecord
  COLORS = %w[
    #f43f5e #ec4899 #d946ef #a855f7 #8b5cf6 #6366f1 #3b82f6 #0ea5e9 #06b6d4 #14b8a6 #10b981
    #22c55e #84cc16 #eab308 #f59e0b #f97316 #ef4444 #78716c #737373 #71717a #6b7280 #64748b
  ].freeze
  belongs_to :account, optional: true

  has_many :tag_maps, as: :taggable, dependent: :destroy
  has_many :tags, through: :tag_maps

  has_one_attached :image

  validates :answer, :prompt, presence: true
  validates :color, presence: true, inclusion: { in: COLORS }
  validates :published, boolean: true

  enum :card_style, { basic: 0, fancy: 1, brutalism: 2 }
end
