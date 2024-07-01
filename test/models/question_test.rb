# == Schema Information
#
# Table name: questions
#
#  id               :bigint           not null, primary key
#  quiz_id          :bigint           not null
#  score            :integer          default(1), not null
#  multiple_answers :boolean          default(FALSE), not null
#  question_text    :text             not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
require "test_helper"

class QuestionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
