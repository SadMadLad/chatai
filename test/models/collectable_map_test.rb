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
require "test_helper"

class CollectableMapTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
