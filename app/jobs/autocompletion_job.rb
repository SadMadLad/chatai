class AutocompletionJob < ApplicationJob
  queue_as :default

  rescue_from Faraday::ConnectionFailed do
    chat = arguments[0]
    message = Message.create(chat:, role: :assistant, content: 'Service not available')

    broadcast_message(chat, message)
    chat.update_column(:chat_status, 'awaiting_user_reply')
  end

  rescue_from StandardError do
    chat = arguments[0]
    message = Message.create(chat:, role: :assistant, content: 'Something bad happened. Later!')

    broadcast_message(chat, message)
    chat.update_column(:chat_status, 'awaiting_user_reply')
  end

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
end
