# == Schema Information
#
# Table name: chats
#
#  id                :bigint           not null, primary key
#  chat_status       :integer
#  chat_type         :integer          default("two_person"), not null
#  chat_title        :string
#  chat_description  :text
#  latest_message_at :datetime         not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
require "test_helper"

class ChatTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
