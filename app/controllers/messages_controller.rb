# frozen_string_literal: true

class MessagesController < AuthenticatedController
  before_action :set_chat
  before_action :authorize_message

  def edit
    @message = Message.find(params[:id])
  end

  def create
    @message = Message.new(**message_params, account: current_account, chat: @chat)
    @message.save
  end

  def update
    @message = Message.find(params[:id])

    @message.update(message_params)
  end

  def destroy
    @message = Message.find(params[:id])

    @message.destroy
  end

  private

  def set_chat
    @chat = Chat.find(params[:chat_id])
  end

  def message_params
    params.require(:message).permit(:body)
  end

  def authorize_message
    authorize @message, policy_class: MessagePolicy
  end
end
