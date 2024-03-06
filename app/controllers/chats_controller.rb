# frozen_string_literal: true

class ChatsController < AuthenticatedController
  before_action :set_chat, only: %i[show destroy]

  before_action -> { define_model_name('chat') }

  def index
    @chats = current_account.chats.where(chat_type: :two_person).order(latest_message_at: :desc)
    paginate_chats
  end

  def group
    @chats = current_account.chats.where(chat_type: :multi_person).order(latest_message_at: :desc)
    paginate_chats
  end

  def show; end

  def create
    other_account = Account.find(params[:account_id])
    if Chat.create_chat([current_account, other_account])
      redirect_to :chats, notice: t(:create, model:)
    else
      redirect_to :chats, alert: t(:failed_create, model:)
    end
  end

  def destroy
    @chat.destroy
    redirect_to :chats, notice: t(:destroy, model:)
  end

  private

  def set_chat
    @chat = Chat.find(params[:id])
    @messages = @chat.messages
  end

  def paginate_chats
    @pagy, @chats = pagy(@chats)
    @accounts = Account.conversing_accounts(current_account, @chats)
    @is_paginated = @pagy.page > 1

    @no_chats = @chats.blank?

    return if @is_paginated || @no_chats

    @chat = @chats.first
    @messages = @chat.messages

    params[:id] = @chat.id
  end
end
