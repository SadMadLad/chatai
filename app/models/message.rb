# frozen_string_literal: true

class Message < ApplicationRecord
  belongs_to :chat, touch: :latest_message_at
  belongs_to :account, touch: :latest_message_at

  validates :body, presence: true
  validates :account_id, presence: true, if: :user?

  enum :role, { user: 0, assistant: 1, system: 2 }
end
