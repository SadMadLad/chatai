# frozen_string_literal: true

module Admin
  # Admin Dashboard for Messages
  class MessagesController < AdminController
    before_action :set_message, only: %i[show edit update destroy]
    before_action :authorize_message
    before_action :set_accounts, only: %i[new create edit update]
    before_action :set_chats, only: %i[new create edit update]

    before_action -> { define_model_name('message') }
    before_action -> { fetch_admin_comments(@message) }, only: :show

    def index
      @pagy, @messages = pagy(Message.includes(:chat).includes(:account))
    end

    def show
      @chat = @message.chat
      @account = @message.account
    end

    def new
      @message = Message.new
    end

    def edit; end

    def create
      @message = Message.new(message_params)
      if @message.save
        redirect_to [:admin, @message], notice: t(:create, model:)
      else
        render :new, status: :unprocessable_entity, alert: t(:failed_create, model:)
      end
    end

    def update
      if @message.update(message_params)
        redirect_to [:admin, @message], notice: t(:update, model:)
      else
        render :edit, status: :unprocessable_entity, alert: t(:failed_update, model:)
      end
    end

    def destroy
      @message.destroy
      redirect_to %i[admin messages], notice: t(:destroy, model:)
    end

    private

    def message_params
      params.require(:message).permit(:account_id, :chat_id, :content)
    end

    def set_message
      @message = Message.find(params[:id])
    end

    def set_accounts
      @accounts = Account.all
    end

    def set_chats
      @chats = Chat.all
    end

    def authorize_message
      authorize @message, policy_class: Admin::AdminPolicy
    end
  end
end
