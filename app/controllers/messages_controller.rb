# frozen_string_literal: true

class MessagesController < AuthenticatedController
  include ChatPagination
  include ActionView::RecordIdentifier
  include ChatsHelper
  include AccountsHelper

  before_action :set_chat
  before_action :set_message, only: %i[edit update destroy]
  before_action :authorize_message

  def edit; end

  def create
    @message = @chat.messages.create(message_params)

    broadcast_new_message if @message.save && !@chat.ai_chat?
  end

  def update
    @message.update(message_params)

    @message.broadcast_replace_to(@chat)
  end

  def destroy
    @message.destroy

    @message.broadcast_remove_to(@chat)
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
    @message.broadcast_append_to(
      @chat, partial: 'messages/message', locals: { message: @message, chat: @chat, scroll_into_view: true }, target: @chat
    )

    conversing_accounts = @chat.accounts
    conversing_accounts.each do |account|
      chat_stream = chat_tab_stream(account, chat_type: @chat.chat_type.to_sym)
      locals = {
        chat_and_account: [@chat, conversing_accounts.excluding(account).first],
        accounts: conversing_accounts, latest_message: @message, chat: @chat, notification: true
      }
      partial = "chats/#{'group_' if @chat.multi_person?}chat_tab"

      @message.broadcast_remove_to(chat_stream, target: chat_tab_id(@chat))
      @message.broadcast_prepend_to(chat_stream, target: 'chat_tabs', partial:, locals:)
    end
  end
end
