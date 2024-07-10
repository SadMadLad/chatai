# frozen_string_literal: true

# == Schema Information
#
# Table name: collectable_maps
#
#  id               :bigint           not null, primary key
#  collectable_type :string           not null
#  collectable_id   :bigint           not null
#  collection_id    :bigint           not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
class CollectableMap < ApplicationRecord
  # The supported collectables should have a column named :collectable_maps_count
  SUPPORTED_COLLECTABLES = %w[FlashCard Quiz].freeze

  belongs_to :collection, counter_cache: :collectable_maps_count
  belongs_to :collectable, polymorphic: true, counter_cache: :collectable_maps_count

  validates :collectable_type, inclusion: { in: SUPPORTED_COLLECTABLES }
end
