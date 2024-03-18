class AccountsController < AuthenticatedController
  before_action :set_account
  before_action :authorize_account

  def show; end

  def edit; end

  def update; end

  def destroy; end

  private

  def account_params
    params.require(:account).permit(:first_name, :last_name, :username)
  end

  def set_account
    @account = Account.find(params[:id])
  end

  def authorize_account
    authorize @account, policy_class: AccountPolicy
  end
end
