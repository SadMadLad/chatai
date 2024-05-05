# frozen_string_literal: true

module Api
  module V1
    # Managing sessions for the API.
    class SessionsController < Api::ApiController
      include JwtService

      def create
        user = User.find_by(email: sign_in_params[:email])
        if user.nil? || !user.valid_password?(sign_in_params[:password])
          render json: { error: 'Invalid email or password' }, status: :unauthorized
        else
          @account_token = AccountToken.find_by(account: user.account, scope: sign_in_params[:scope])
          @account = @account_token.account
          authenticate_token
        end
      end

      def destroy
        authenticate_account_token!

        @account.update(active_at_frontend: false)
        render json: { error: 'Signed Out successfully!' }, status: :ok
      end

      private

      def sign_in_params
        @sign_in_params ||= params.require(:user).permit(:email, :password, :scope)
      end

      def authenticate_token
        if @account_token.present?
          @account_token.account.update(active_at_frontend: true)
          render json: response_payload
        else
          render json: { error: 'Please create the API from the main portal' }, status: :unauthorized
        end
      end

      def response_payload
        { token: encode(@account_token.id), full_name: @account.full_name, avatar_url: url_for(@account.avatar) }
      end
    end
  end
end
