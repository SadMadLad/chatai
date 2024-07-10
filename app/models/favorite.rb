# frozen_string_literal: true

# == Schema Information
#
# Table name: favorites
#
#  id               :bigint           not null, primary key
#  account_id       :bigint           not null
#  favoritable_type :string           not null
#  favoritable_id   :bigint           not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
class Favorite < ApplicationRecord
  # Each supported favoritable model must have a favorites_count column
  SUPPORTED_FAVORITABLES = %w[FlashCard Quiz].freeze

  belongs_to :account, counter_cache: :favorites_count
  belongs_to :favoritable, polymorphic: true, counter_cache: :favorites_count

  validates :favoritable_type, inclusion: { in: SUPPORTED_FAVORITABLES }
end
