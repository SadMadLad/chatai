# frozen_string_literal: true

# == Schema Information
#
# Table name: feedbacks
#
#  id            :bigint           not null, primary key
#  account_id    :bigint           not null
#  platform      :integer          not null
#  feedback_body :text             not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
# User's feedback on a platform.
class Feedback < ApplicationRecord
  belongs_to :account

  validates :feedback_body, :platform, presence: true

  enum :platform, { chatai: 0, frontend: 1 }
end
