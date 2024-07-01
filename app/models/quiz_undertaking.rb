# frozen_string_literal: true

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
# Instance of user taking a quiz.
class QuizUndertaking < ApplicationRecord
  belongs_to :account
  belongs_to :quiz, counter_cache: true

  validates :correct_answers, presence: true, comparison: { greater_than_or_equal_to: 0 }
end
