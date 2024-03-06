# frozen_string_literal: true

class Message < ApplicationRecord
  belongs_to :chat, touch: :latest_message_at
  belongs_to :account, touch: :latest_message_at

  validates :body, presence: true
end