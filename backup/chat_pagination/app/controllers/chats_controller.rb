# frozen_string_literal: true

class ChatsController < AuthenticatedController
  include ChatPagination

  before_action :set_chat, only: %i[show destroy]
  before_action :set_new_message, only: %i[index group show]
  before_action :authorize_chat
  before_action -> { define_model_name('chat') }

  def index
    paginate_account_chats(current_account, :two_person)
  end

  def group
    paginate_account_chats(current_account, :multi_persion)
  end

  def show
    @messages = @chat.messages.includes(:account)
    @message = Message.new
  end

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
  end

  def set_new_message
    @message = Message.new
  end

  def authorize_chat
    authorize @chat, policy_class: ChatPolicy
  end
end
