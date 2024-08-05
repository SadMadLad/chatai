# == Schema Information
#
# Table name: request_logs
#
#  id             :bigint           not null, primary key
#  account_id     :bigint
#  user_id        :bigint
#  should_be_kept :boolean          default(FALSE), not null
#  status         :integer          not null
#  db_runtime     :float            not null
#  total_runtime  :float            not null
#  view_runtime   :float            not null
#  action         :string           not null
#  controller     :string           not null
#  full_url       :string           not null
#  user_email     :string
#  extra_params   :jsonb
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
require "test_helper"

class RequestLogTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
