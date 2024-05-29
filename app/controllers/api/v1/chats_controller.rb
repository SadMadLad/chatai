# frozen_string_literal: true

module Api
  module V1
    # Chats at the frontend
    class ChatsController < Api::AuthenticatedController
      def index
        @chats = Chat.where(chat_type: 'live_room').all
      end

      def show
        @chat = Chat.find(params[:id])
        @messages = @chat.messages.includes(account: { avatar_attachment: :blob })
      end
    end
  end
end
