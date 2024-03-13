# frozen_string_literal: true

module ChatsHelper
  def selected_chat?(chat)
    params[:controller] == 'chats' && params[:id] == chat.id
  end

  def chat_message_class(message)
    'text-right'
    # message.account == current_account ? 'text-right' : 'text-left'
  end
end
