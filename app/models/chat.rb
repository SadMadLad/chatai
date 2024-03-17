# frozen_string_literal: true

class Chat < ApplicationRecord
  after_initialize { self.latest_message_at = DateTime.now if new_record? }

  has_many :messages, dependent: :destroy
  has_many :account_chat_maps, dependent: :destroy
  has_many :accounts, through: :account_chat_maps

  validates :chat_type, :latest_message_at, presence: true

  enum :chat_type, { two_person: 0, multi_person: 1 }

  class << self
    def create_chat(accounts, return_chat: false)
      return return_chat ? Chat.new : false if accounts.size < 2

      chat_type = accounts.size == 2 ? :two_person : :multi_person
      chat = new(chat_type:)

      AccountChatMap.create(accounts.map { |account| { account:, chat: } }) if chat.save

      return_chat ? chat : chat.persisted?
    end

    def include_messages_accounts_avatars
      includes(:messages, accounts: { avatar_attachment: :blob })
    end
  end
end
