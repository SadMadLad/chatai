# frozen_string_literal: true

# Controller for managing account tokens.
class AccountTokensController < AuthenticatedController
  before_action :set_account_tokens, only: %i[index create]

  def index
    @account_token = AccountToken.new
  end

  def create
    @account_token = AccountToken.new(account_token_params)

    if @account_token.save
      redirect_to account_tokens_path
    else
      render :index, status: :unprocessable_entity
    end
  end

  def destroy
    @account_token = AccountToken.find(params[:id])
    @account_token.destroy

    redirect_to [:account_tokens]
  end

  private

  def account_token_params
    params.require(:account_token).permit(:scope).merge(account: current_account)
  end

  def set_account_tokens
    @account_tokens = AccountToken.where(account: current_account)
  end
end
