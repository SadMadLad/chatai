# frozen_string_literal: true

# == Schema Information
#
# Table name: messages
#
#  id         :bigint           not null, primary key
#  account_id :bigint
#  chat_id    :bigint           not null
#  role       :integer          default("user"), not null
#  content    :text             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Message belonging to a chat
class Message < ApplicationRecord
  belongs_to :chat, touch: :latest_message_at
  belongs_to :account, touch: :latest_message_at, optional: true

  validates :content, presence: true
  validates :account_id, presence: true, if: :user?

  enum :role, { user: 0, assistant: 1, system: 2 }
end
