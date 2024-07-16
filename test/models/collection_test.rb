# == Schema Information
#
# Table name: collections
#
#  id                     :bigint           not null, primary key
#  account_id             :bigint           not null
#  public                 :boolean          default(TRUE), not null
#  collectable_maps_count :integer          default(0), not null
#  favorites_count        :integer          default(0), not null
#  items_count            :integer          default(0), not null
#  color                  :string           not null
#  title                  :string           not null
#  description            :text
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
require "test_helper"

class CollectionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
