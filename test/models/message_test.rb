# == Schema Information
#
# Table name: messages
#
#  id         :bigint           not null, primary key
#  account_id :bigint
#  chat_id    :bigint           not null
#  role       :integer          default("user"), not null
#  content    :text             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require "test_helper"

class MessageTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
