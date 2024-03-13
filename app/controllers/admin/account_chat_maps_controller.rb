# frozen_string_literal: true

module Admin
  class AccountChatMapsController < AdminController
    before_action :set_account_chat_map, only: %i[show destroy]
    before_action :authorize_account_chat_map

    before_action -> { define_model_name('account chat map') }
    before_action -> { fetch_admin_comments(@account_chat_map) }, only: :show

    def index
      @pagy, @account_chat_maps = pagy(AccountChatMap.includes(:account).includes(:chat))
    end

    def show
      @chat = @account_chat_map.chat
      @account = @account_chat_map.account
    end

    def destroy
      @account_chat_map.destroy
      redirect_to %i[admin account_chat_maps], notice: t(:create, model:)
    end

    private

    def set_account_chat_map
      @account_chat_map = AccountChatMap.find(params[:id].split('_'))
    end

    def authorize_account_chat_map
      authorize @account_chat_map, policy_class: Admin::AccountChatMapPolicy
    end
  end
end
