# == Schema Information
#
# Table name: tags
#
#  id         :bigint           not null, primary key
#  tag_type   :integer          default("display"), not null
#  tag        :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require "test_helper"

class TagTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
