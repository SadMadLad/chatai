# == Schema Information
#
# Table name: accounts
#
#  id                :bigint           not null, primary key
#  user_id           :bigint           not null
#  favorites_count   :integer          default(0), not null
#  role              :integer          default("user"), not null
#  first_name        :string           not null
#  last_name         :string           not null
#  username          :string           not null
#  tagline           :text
#  latest_message_at :datetime
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
require "test_helper"

class AccountTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
