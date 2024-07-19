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
          @current_account_token = AccountToken.find_by(account: user.account, scope: sign_in_params[:scope])
          authenticate_token
        end
      end

      private

      def sign_in_params
        @sign_in_params ||= params.require(:user).permit(:email, :password, :scope)
      end

      def authenticate_token
        if @current_account_token.present?
          @current_account = @current_account_token.account
          render json: response_payload
        else
          render json: { error: 'Please create the API from the main portal' }, status: :unauthorized
        end
      end

      def response_payload
        {
          token: encode(@current_account_token.id),
          full_name: @current_account.full_name,
          username: @current_account.username,
          avatar_url: @current_account.avatar.attached? ? url_for(@current_account.avatar) : nil
        }
      end
    end
  end
end
