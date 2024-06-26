# frozen_string_literal: true

# Managing chats - both the two-way as well as group ones.
class ChatsController < AuthenticatedController
  include ChatPagination

  before_action :set_chat, only: %i[show details autocomplete destroy]
  before_action :set_new_message, only: %i[index group show]
  before_action :authorize_chat
  before_action -> { define_model_name('chat') }

  def index
    paginate_account_chats(current_account, :two_person)
  end

  def group
    paginate_account_chats(current_account, :multi_person)
  end

  def ai_chats
    @chats = current_user.chats.where(chat_type: :ai_chat)
  end

  def show
    @messages = @chat.messages.includes(account: { avatar_attachment: :blob })
    @other_account = @chat.other_account(current_account) if @chat.two_person?
    @message = Message.new
  end

  def details
    @accounts = @chat.accounts
    @messages = @chat.messages
  end

  def create
    other_account = Account.find(params[:account])

    chat = Chat.create_chat([current_account, other_account])
    if chat.present?
      redirect_to chats_path(chat_id: chat.id)
    else
      redirect_to :chats, status: :unprocessable_entity, alert: t(:failed_create, model:)
    end
  end

  def autocomplete
    AutocompletionJob.perform_later(@chat)

    head :ok
  end

  def destroy
    @chat.destroy

    redirect_to :chats, notice: t(:destroy, model:)
  end

  private

  def chat_params
    params.require(:chat).permit
  end

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
