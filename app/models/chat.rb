# frozen_string_literal: true

# == Schema Information
#
# Table name: chats
#
#  id                :bigint           not null, primary key
#  chat_status       :integer
#  chat_type         :integer          default("two_person"), not null
#  chat_title        :string
#  chat_description  :text
#  latest_message_at :datetime         not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
# Chat Model. Can be group chat as well as two-person chat.
class Chat < ApplicationRecord
  after_initialize { self.latest_message_at = DateTime.now if new_record? }

  has_one_attached :photo

  has_many :messages, dependent: :destroy
  has_many :account_chat_maps, dependent: :destroy
  has_many :accounts, through: :account_chat_maps
  has_many :tag_maps, as: :taggable, dependent: :destroy
  has_many :tags, -> { where(chat_type: :live_room) }, through: :tag_maps

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
    def create_chat(accounts)
      return false if accounts.uniq.length < 2

      chat_type = accounts.length == 2 ? :two_person : :multi_person
      chat_title = chat_type == :multi_person ? "Group Chat #{accounts.length}" : nil
      chat_description = chat_title

      if chat_type == :two_person
        account_chat_maps = AccountChatMap.chat_between_accounts(*accounts.map(&:id))

        return account_chat_maps.first.chat if account_chat_maps.present?
      end

      create_new_chat(chat_description, chat_title, chat_type, accounts)
    end

    def create_new_chat(chat_description, chat_title, chat_type, accounts)
      chat = new(chat_description:, chat_title:, chat_type:)
      return false unless chat.save

      AccountChatMap.create(accounts.map { |account| { account:, chat: } })
      chat
    end

    def eager_load_by_chat_type(chat_type)
      chat_type == :multi_person ? includes(:messages, :accounts) : includes(:messages)
    end
  end
end
