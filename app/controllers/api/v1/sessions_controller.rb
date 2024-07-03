# frozen_string_literal: true

module Api
  module V1
    # Managing sessions for the API.
    class SessionsController < Api::ApiController
      include JwtService

      before_action :authenticate_account_token!, only: %i[verify_session destroy]

      def create
        user = User.find_by(email: sign_in_params[:email])
        if user.nil? || !user.valid_password?(sign_in_params[:password])
          render json: { error: 'Invalid email or password' }, status: :unauthorized
        else
          @account_token = AccountToken.find_by(account: user.account, scope: sign_in_params[:scope])
          authenticate_token
        end
      end

      def verify_session
        render json: response_payload
      end

      def destroy
        render json: { error: 'Signed Out successfully!' }, status: :ok
      end

      private

      def sign_in_params
        @sign_in_params ||= params.require(:user).permit(:email, :password, :scope)
      end

      def authenticate_token
        if @account_token.present?
          @account = @account_token.account
          render json: response_payload
        else
          render json: { error: 'Please create the API from the main portal' }, status: :unauthorized
        end
      end

      def response_payload
        {
          token: encode(@account_token.id),
          full_name: @account.full_name,
          username: @account.username,
          avatar_url: @account.avatar.attached? ? url_for(@account.avatar) : nil,
        }
      end
    end
  end
end
