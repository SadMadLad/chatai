# == Schema Information
#
# Table name: feedbacks
#
#  id            :bigint           not null, primary key
#  account_id    :bigint           not null
#  platform      :integer          not null
#  feedback_body :text             not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
require "test_helper"

class FeedbackTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
