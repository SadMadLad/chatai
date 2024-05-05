# frozen_string_literal: true

# Chat Model. Can be group as well as two-way.
class Chat < ApplicationRecord
  after_initialize { self.latest_message_at = DateTime.now if new_record? }

  has_many :messages, dependent: :destroy, strict_loading: true
  has_many :account_chat_maps, dependent: :destroy
  has_many :accounts, through: :account_chat_maps

  validates :chat_type, :latest_message_at, presence: true
  validates :chat_title, presence: true, unless: :two_person?
  validates :chat_status, presence: true, if: :ai_chat?

  enum :chat_type, { two_person: 0, multi_person: 1, ai_chat: 2 }
  enum :chat_status, { awaiting_user_reply: 0, processing: 1 }

  default_scope -> { includes(:messages) }

  def other_account(account)
    raise NoMethodError unless two_person?

    accounts.excluding(account).first
  end

  def tab_id
    "chat_#{id}_tab"
  end

  class << self
    def create_chat(accounts, return_chat: false)
      return false if accounts.size < 2

      chat_type = accounts.size == 2 ? :two_person : :multi_person
      chat_title = chat_type == :multi_person ? "Group Chat #{accounts.size}" : nil
      chat = new(chat_type:, chat_title:)

      return false unless chat.save

      AccountChatMap.create(accounts.map { |account| { account:, chat: } })
      return_chat ? chat : chat.persisted?
    end

    def include_messages_accounts_avatars
      includes(:messages, accounts: { avatar_attachment: :blob })
    end
  end
end
