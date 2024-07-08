# == Schema Information
#
# Table name: comments
#
#  id               :bigint           not null, primary key
#  account_id       :bigint           not null
#  commentable_type :string           not null
#  commentable_id   :bigint           not null
#  likes_count      :integer          default(0), not null
#  body             :text
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
require "test_helper"

class CommentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
