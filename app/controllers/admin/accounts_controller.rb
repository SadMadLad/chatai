# frozen_string_literal: true

module Admin
  # Admin Dashboard for acounts.
  class AccountsController < AdminController
    before_action :set_account, only: %i[show edit update destroy]
    before_action :authorize_account

    before_action -> { define_model_name('account') }
    before_action -> { fetch_admin_comments(@account) }, only: :show

    def index
      @pagy, @accounts = pagy(Account.all)
    end

    def show; end

    def edit; end

    def update
      if @account.update(account_params)
        redirect_to [:admin, @account], notice: t(:update, model:)
      else
        render :edit, status: :unprocessable_entity, alert: t(:failed_update, model:)
      end
    end

    def destroy
      return if @account.superadmin?

      @account.destroy
      redirect_to [:admin, @account], notice: t(:destroy, model:)
    end

    private

    def set_account
      @account = Account.find(params[:id])
    end

    def authorize_account
      authorize @account, policy_class: Admin::AccountPolicy
    end

    def account_params
      params.require(:account).permit(:first_name, :last_name, :username, :role)
    end
  end
end
