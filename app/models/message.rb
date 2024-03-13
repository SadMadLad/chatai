# frozen_string_literal: true

class Message < ApplicationRecord
  attr_accessor :skip_broadcast_callbacks

  belongs_to :chat, touch: :latest_message_at
  belongs_to :account, touch: :latest_message_at

  after_create_commit lambda {
                        broadcast_append_to chat, partial: 'messages/message', locals: { message: self }, target: chat
                      }, unless: :skip_broadcast_callbacks
  after_update_commit -> { broadcast_replace_to self }, unless: :skip_broadcast_callbacks
  after_destroy_commit -> { broadcast_remove_to self }, unless: :skip_broadcast_callbacks

  validates :body, presence: true
end
