# == Schema Information
#
# Table name: ratings
#
#  id            :bigint           not null, primary key
#  rateable_type :string           not null
#  rateable_id   :bigint           not null
#  rating        :integer          default(0), not null
#  account_id    :bigint           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
require "test_helper"

class RatingTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
