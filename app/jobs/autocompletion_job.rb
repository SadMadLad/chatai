# frozen_string_literal: true

# Autocomplete that AI chat and generate its response.
class AutocompletionJob < ApplicationJob
  rescue_from Faraday::ConnectionFailed, with: -> { logger('job_errors.connection_failed') }
  rescue_from Faraday::TimeoutError, with: -> { logger('job_errors.timeout_error') }

  def perform(chat, limit: 5)
    return unless chat.ai_chat?

    chat.update_column(:chat_status, 'processing')
    content = JSON.parse autocomplete_reply(chat, limit || 5).body
    role = :assistant

    message = Message.create(content:, chat:, role:)
    broadcast_message(chat, message)
  end

  private

  def autocomplete_reply(chat, limit)
    messages = chat.messages.order(:created_at).last(limit)
    client = Clients::ApiClient.new

    client.autocomplete(messages)
  end

  def broadcast_message(chat, message)
    locals = { message:, chat:, scroll_into_view: true, new_message: true }
    message.broadcast_append_to(chat, partial: 'messages/message', locals:, target: chat)

    chat.update_column(:chat_status, 'awaiting_user_reply')
  end

  def respond_error_to_user(error_message)
    chat = arguments[0]
    message = Message.create(chat:, content: error_message, role: :assistant)

    broadcast_message(chat, message)
  end
end
