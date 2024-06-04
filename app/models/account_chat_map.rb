# frozen_string_literal: true

# In-between association between accounts and chats.
class AccountChatMap < ApplicationRecord
  belongs_to :account
  belongs_to :chat

  validates :account_id, uniqueness: { scope: :chat_id }

  class << self
    def chat_between_accounts(account_id_one, account_id_two)
      AccountChatMap.joins('JOIN account_chat_maps AS acm2 ON account_chat_maps.chat_id = acm2.chat_id')
                    .where('account_chat_maps.account_id = ? AND acm2.account_id = ?', account_id_one, account_id_two)
                    .joins(:chat)
                    .where(chat: { chat_type: :two_person })
    end
  end
end
