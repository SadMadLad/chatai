# frozen_string_literal: true

module ChatPagination
  extend ActiveSupport::Concern

  def paginate_account_chats(account, chat_type)
    @chats = account.chats.where(chat_type:).order(latest_message_at: :desc)

    @pagy, @chats = pagy(@chats)
    @accounts = Account.conversing_accounts(account, @chats)

    @is_paginated = @pagy.page > 1
    @no_chats = @chats.blank?

    return if @is_paginated || @no_chats

    @chat = @chats.first
    @messages = @chat.messages.includes(:account)

    params[:id] = @chat.id
  end
end
