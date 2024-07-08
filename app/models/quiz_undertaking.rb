# frozen_string_literal: true

# == Schema Information
#
# Table name: quiz_undertakings
#
#  id         :bigint           not null, primary key
#  account_id :bigint           not null
#  quiz_id    :bigint           not null
#  score      :float            default(0.0), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class QuizUndertaking < ApplicationRecord
  belongs_to :account
  belongs_to :quiz, counter_cache: true, touch: :latest_taken_at

  validates :score, presence: true

  validate :score_within_range

  def score_within_range
    return if score.between?(0, quiz.total_score)

    errors.add(:score, 'must be within 0 and the total score')
  end
end
