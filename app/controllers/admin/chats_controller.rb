# frozen_string_literal: true

module Admin
  # Admin Dashboard for Chats
  class ChatsController < Admin::AdminController
    before_action :set_chat, only: %i[show destroy]
    before_action :set_accounts, only: %i[new create]
    before_action :authorize_chat

    before_action -> { define_model_name('chat') }
    before_action -> { fetch_admin_comments(@chat) }, only: :show

    def index
      @pagy, @chats = pagy(Chat.includes(:account_chat_maps))
    end

    def show
      @accounts = @chat.accounts
      @messages = Message.includes(:account).where(chat: @chat)
    end

    def new
      @chat = Chat.new
    end

    def create
      accounts = Account.where(id: chat_account_params)
      @chat = Chat.create_chat(accounts)

      if @chat.save
        redirect_to [:admin, @chat], notice: t(:create, model:)
      else
        render :new, status: :unprocessable_entity, alert: t(:failed_create, model:)
      end
    end

    def destroy
      @chat.destroy
      redirect_to %i[admin chats], notice: t(:destroy, model:)
    end

    private

    def set_chat
      @chat = Chat.find(params[:id])
    end

    def set_accounts
      @accounts = Account.order(:first_name)
    end

    def chat_account_params
      params.require(:chat).permit(account_ids: [])['account_ids']
    end

    def authorize_chat
      authorize @chat, policy_class: Admin::ChatPolicy
    end
  end
end
