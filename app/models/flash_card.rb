# frozen_string_literal: true

# == Schema Information
#
# Table name: flash_cards
#
#  id                     :bigint           not null, primary key
#  account_id             :bigint
#  card_style             :integer          default("basic"), not null
#  collectable_maps_count :integer          default(0), not null
#  favorites_count        :integer          default(0), not null
#  color                  :string           default("#84cc16"), not null
#  answer                 :text             not null
#  prompt                 :text             not null
#  published              :boolean          default(FALSE), not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

# Flash Card
class FlashCard < ApplicationRecord
  include Collectable
  include Colors
  include Embeddable
  include Favoritable
  include Taggable

  belongs_to :account, optional: true

  has_one_attached :image

  validates :answer, :prompt, presence: true
  validates :published, boolean: true

  embeddable_text columns: %i[answer prompt]

  enum :card_style, { basic: 0, fancy: 1, brutalism: 2 }
end
