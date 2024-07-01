# == Schema Information
#
# Table name: quizzes
#
#  id                      :bigint           not null, primary key
#  account_id              :bigint
#  timer                   :integer
#  questions_count         :integer          default(0), not null
#  quiz_undertakings_count :integer          default(0), not null
#  rating_count            :integer          default(0), not null
#  total_score             :integer          default(0), not null
#  total_rating            :integer          default(0), not null
#  title                   :string           not null
#  published               :boolean          default(FALSE), not null
#  timed                   :boolean          default(FALSE), not null
#  description             :text             not null
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#
require "test_helper"

class QuizTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
