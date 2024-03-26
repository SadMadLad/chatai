# frozen_string_literal: true

class MessagesController < AuthenticatedController
  include ChatPagination

  before_action :set_chat
  before_action :authorize_message

  def create
    @message = @chat.messages.new(message_params)

    broadcast_new_message if @message.save
    render status: @message.persisted? ? :created : :unprocessable_entity
  end

  private

  def set_message
    @message = Message.find(params[:id])
  end

  def set_chat
    @chat = Chat.find(params[:chat_id])
  end

  def message_params
    params.require(:message).permit(:content).merge(account: current_account)
  end

  def authorize_message
    authorize @message, policy_class: MessagePolicy
  end

  def broadcast_new_message
    broadcast_append_message
    return if @chat.ai_chat?

    conversing_accounts = @chat.accounts

    conversing_accounts.each do |account|
      account_chat_stream = account.sidebar_stream_id(chat_type: @chat.chat_type.to_sym)
      locals = build_locals(conversing_accounts, account)
      partial = set_partial

      update_chat_tabs(account_chat_stream, partial, locals)
    end
  end

  def broadcast_append_message
    locals = { message: @message, chat: @chat, scroll_into_view: true, new_message: true }

    @message.broadcast_append_to(@chat, partial: 'messages/message', locals:, target: @chat)
  end

  def update_chat_tabs(account_chat_stream, partial, locals)
    @message.broadcast_remove_to(account_chat_stream, target: @chat.tab_id)
    @message.broadcast_prepend_to(account_chat_stream, target: 'chat_tabs', partial:, locals:)
  end

  def build_locals(chat_accounts, exclude_account)
    locals = {}

    locals[:latest_message] = @message
    locals[:chat] = @chat
    locals[:notification] = true

    if @chat.two_person?
      locals[:chat_and_account] = [@chat, chat_accounts.excluding(exclude_account).first]
    else
      locals[:accounts] = chat_accounts
    end

    locals
  end

  def set_partial
    "chats/#{'group_' if @chat.multi_person?}chat_tab"
  end
end
