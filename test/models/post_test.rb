# == Schema Information
#
# Table name: posts
#
#  id          :bigint           not null, primary key
#  account_id  :bigint           not null
#  likes_count :integer          default(0), not null
#  title       :string           not null
#  body        :text             not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
require "test_helper"

class PostTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
