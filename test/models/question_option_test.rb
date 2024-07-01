# == Schema Information
#
# Table name: question_options
#
#  id          :bigint           not null, primary key
#  question_id :bigint           not null
#  correct     :boolean          default(FALSE), not null
#  option_text :text             not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
require "test_helper"

class QuestionOptionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
