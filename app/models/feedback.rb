class Feedback < ApplicationRecord
  belongs_to :account

  validates :feedback_body, :platform, presence: true

  enum :platform, { chatai: 0, frontend: 1 }
end
