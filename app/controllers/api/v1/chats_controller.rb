module Api
  module V1
    class ChatsController < Api::AuthenticatedController
      def index
        @chats = Chat.where(chat_type: 'live_room').all
      end

      def show
        @chat = Chat.find(params[:id])
        @messages = @chat.messages.includes(:account)
      end
    end
  end
end
