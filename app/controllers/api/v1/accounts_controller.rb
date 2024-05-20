module Api
  module V1
    class AccountsController < Api::AuthenticatedController
      def public
        @other_account = Account.find(params[:identifier])
        @live_chats = Chat.joins(messages: :account).where(account: { id: @other_account }, chat_type: :live_room)
        @latest_messages = @other_account.messages.joins(:chat).where(chat: { chat_type: :live_room }).last(5)

        render json: public_account_payload
      end

      private

      def public_account_payload
        filter_account_fields = %i[active_at_frontend first_name last_name latest_message_at tagline]

        {
          live_chats: @live_chats,
          latest_messages: @latest_messages,
          avatar_url: @other_account.avatar.attached? ? url_for(@other_account.avatar) : nil,
          account: @other_account.as_json(only: filter_account_fields)
        }
      end
    end
  end
end
