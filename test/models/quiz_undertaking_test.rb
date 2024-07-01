# == Schema Information
#
# Table name: quiz_undertakings
#
#  id              :bigint           not null, primary key
#  account_id      :bigint           not null
#  quiz_id         :bigint           not null
#  correct_answers :float            default(0.0), not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
require "test_helper"

class QuizUndertakingTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
