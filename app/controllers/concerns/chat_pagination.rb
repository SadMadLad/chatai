# frozen_string_literal: true

module ChatPagination
  extend ActiveSupport::Concern

  def paginate_account_chats(account, chat_type)
    @chats = account.chats.where(chat_type:)
                    .include_messages_accounts_avatars
                    .order(latest_message_at: :desc)
    @accounts = Account.conversing_accounts(account, @chats) unless chat_type == :ai_person

    return if @chats.blank?

    @chat = @chats.first
    @messages = @chat.messages.includes(:account)
    params[:id] = @chat.id

    @other_account = @chat.other_account(current_account) if @chat.two_person?
  end
end
