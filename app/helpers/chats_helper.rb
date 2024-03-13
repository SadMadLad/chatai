# frozen_string_literal: true

module ChatsHelper
  def selected_chat?(chat)
    params[:controller] == 'chats' && params[:id] == chat.id
  end
end
