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
require "test_helper"

class FavoriteTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
