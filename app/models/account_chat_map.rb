# frozen_string_literal: true

# In-between association between accounts and chats.
class AccountChatMap < ApplicationRecord
  belongs_to :account
  belongs_to :chat

  validates :account_id, uniqueness: { scope: :chat_id }
end
