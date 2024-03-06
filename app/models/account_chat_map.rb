# frozen_string_literal: true

class AccountChatMap < ApplicationRecord
  belongs_to :account
  belongs_to :chat

  validates :account_id, uniqueness: { scope: :chat_id }
end
