# frozen_string_literal: true

module Admin
  class UsersController < AdminController
    before_action :set_user, only: %i[show edit update destroy]
    before_action :authorize_user

    before_action -> { define_model_name('user') }
    before_action -> { fetch_admin_comments(@user) }, only: :show

    def index
      @pagy, @users = pagy(User.includes(:account).all)
    end

    def show; end

    def new
      @user = User.new
      @user.build_account
    end

    def edit; end

    def create
      @user = User.new(user_params)
      if @user.save
        redirect_to [:admin, @user], notice: t(:create, model:)
      else
        render :new, status: :unprocessable_entity, alert: t(:failed_create, model:)
      end
    end

    def update
      if @user.update(user_params)
        redirect_to [:admin, @user], notice: t(:update, model:)
      else
        render :edit, status: :unprocessable_entity, alert: t(:failed_update, model:)
      end
    end

    def destroy
      @user.destroy
      redirect_to %i[admin users], notice: t(:destroy, model:)
    end

    private

    def authorize_user
      authorize @user, policy_class: Admin::UserPolicy
    end

    def set_user
      @user = User.find params[:id]
    end

    def user_params
      params.require(:user).permit(:email, :password, account_attributes: %i[first_name last_name username])
    end
  end
end
