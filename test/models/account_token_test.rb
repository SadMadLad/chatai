# == Schema Information
#
# Table name: account_tokens
#
#  id         :bigint           not null, primary key
#  account_id :bigint           not null
#  scope      :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require "test_helper"

class AccountTokenTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
