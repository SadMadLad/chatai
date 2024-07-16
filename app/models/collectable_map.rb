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
  belongs_to :collection, counter_cache: :collectable_maps_count
  belongs_to :collectable, polymorphic: true, counter_cache: :collectable_maps_count

  validates :collectable_type, inclusion: { in: Collection::COLLECTABLE_MODELS }
  validates :collection_id, uniqueness: { scope: %i[collectable_id collectable_type] }
end
