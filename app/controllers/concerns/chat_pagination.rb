# frozen_string_literal: true

# Module to 'infinite load' chats.
module ChatPagination
  extend ActiveSupport::Concern

  def paginate_account_chats(account, chat_type)
    @chats = account.chats.where(chat_type:)
                    .eager_load_by_chat_type(chat_type)
                    .order(latest_message_at: :desc)
    @accounts = Account.conversing_accounts(account, @chats) unless chat_type == :ai_person

    return if @chats.blank?

    @chat = params[:chat_id].present? ? Chat.find(params[:chat_id]) : @chats.first
    @messages = @chat.messages.includes(account: :avatar_attachment)
    params[:id] = @chat.id

    @other_account = @chat.other_account(current_account) if @chat.two_person?
  end
end
