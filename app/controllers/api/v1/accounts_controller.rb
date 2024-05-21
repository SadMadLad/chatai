# frozen_string_literal: true

module Api
  module V1
    # Frontend Accounts Controller
    class AccountsController < Api::AuthenticatedController
      def public
        @other_account = Account.find_by!(unique_identifier: params[:identifier])
        @live_chats = Chat
                      .includes({ photo_attachment: :blob })
                      .joins(messages: :account)
                      .where(account: { id: @other_account }, chat_type: :live_room)
                      .distinct
        @latest_messages = @other_account
                           .messages
                           .includes(:chat)
                           .where(chat: { chat_type: :live_room }).last(5)
      end
    end
  end
end
