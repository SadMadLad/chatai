# frozen_string_literal: true

class Chat < ApplicationRecord
  after_initialize { self.latest_message_at = DateTime.now if new_record? }

  has_many :messages, dependent: :destroy, strict_loading: true
  has_many :account_chat_maps, dependent: :destroy
  has_many :accounts, through: :account_chat_maps

  validates :chat_type, :latest_message_at, presence: true
  validates :group_title, presence: true, unless: :two_person?

  enum :chat_type, { two_person: 0, multi_person: 1, ai_chat: 2 }

  default_scope -> { includes(:messages) }

  def other_account(account)
    raise NoMethodError unless two_person?

    accounts.excluding(account).first
  end

  class << self
    def create_chat(accounts, return_chat: false)
      return return_chat ? Chat.new : false if accounts.size < 2

      accounts_count = accounts.size
      chat_type = accounts_count == 2 ? :two_person : :multi_person
      group_title = chat_type == :multi_person ? "Group Chat #{accounts_count}" : nil
      chat = new(chat_type:, group_title:)

      AccountChatMap.create(accounts.map { |account| { account:, chat: } }) if chat.save

      return_chat ? chat : chat.persisted?
    end

    def include_messages_accounts_avatars
      includes(:messages, accounts: { avatar_attachment: :blob })
    end
  end
end
