# frozen_string_literal: true

module ChatPagination
  extend ActiveSupport::Concern

  def paginate_account_chats(account, chat_type)
    @chats = account.chats.where(chat_type:)
                    .include_messages_accounts_avatars
                    .order(latest_message_at: :desc)
    @accounts = Account.conversing_accounts(account, @chats)

    return if @chats.blank?

    @chat = @chats.first
    @messages = @chat.messages.includes(:account)
    params[:id] = @chat.id
  end
end
