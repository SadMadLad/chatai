# == Schema Information
#
# Table name: admin_comments
#
#  id                     :bigint           not null, primary key
#  admin_commentable_type :string           not null
#  admin_commentable_id   :bigint           not null
#  commenter_id           :bigint           not null
#  body                   :text             not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
require "test_helper"

class AdminCommentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
