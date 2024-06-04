# frozen_string_literal: true

# Controller to update account settings.
class AccountsController < AuthenticatedController
  before_action :set_account, only: %i[show edit update destroy]
  before_action :authorize_account
  before_action -> { define_model_name('account') }

  def index
    @pagy, @accounts = pagy(
      Account
        .includes(avatar_attachment: :blob)
        .all
    )
  end

  def show; end

  def edit; end

  def update
    if @account.update(account_params)
      redirect_to @account, notice: t(:update, model:)
    else
      render :edit, status: :unprocessable_entity, alert: t(:update, model:)
    end
  end

  def destroy
    @account.destroy
    redirect_to root_path
  end

  private

  def account_params
    params.require(:account).permit(:first_name, :last_name, :username, :avatar)
  end

  def set_account
    @account = Account.find(params[:id])
  end

  def authorize_account
    authorize @account, policy_class: AccountPolicy
  end
end
