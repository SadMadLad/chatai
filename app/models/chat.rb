# frozen_string_literal: true

# Chat Model. Can be group as well as two-way.
class Chat < ApplicationRecord
  after_initialize { self.latest_message_at = DateTime.now if new_record? }

  has_one_attached :photo

  has_many :messages, dependent: :destroy
  has_many :account_chat_maps, dependent: :destroy
  has_many :accounts, through: :account_chat_maps

  validates :chat_description, presence: true, if: :multi_person? || :live_room?
  validates :chat_type, presence: true
  validates :chat_title, presence: true, unless: :two_person?
  validates :chat_status, presence: true, if: :ai_chat?
  validates :latest_message_at, presence: true

  enum :chat_type, { two_person: 0, multi_person: 1, ai_chat: 2, live_room: 3 }
  enum :chat_status, { awaiting_user_reply: 0, processing: 1 }

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
      chat_description = chat_title

      chat = new(chat_description:, chat_title:, chat_type:)
      return false unless chat.save

      AccountChatMap.create(accounts.map { |account| { account:, chat: } })
      return_chat ? chat : chat.persisted?
    end

    def eager_load_by_chat_type(chat_type)
      chat_type == :multi_person ? includes(:messages, :accounts) : includes(:messages)
    end
  end
end
