# frozen_string_literal: true

module Api
  module V1
    class SessionsController < Api::ApiController
      include JwtService

      def create
        user = User.find_by(email: sign_in_params[:email])
        if user.nil? || !user.valid_password?(sign_in_params[:password])
          render json: { error: 'Invalid email or password' }, status: :unauthorized
        else
          @account_token = AccountToken.find_by(account: user.account, scope: sign_in_params[:scope])
          authenticate_token
        end
      end

      private

      def sign_in_params
        @sign_in_params ||= params.require(:user).permit(:email, :password, :scope)
      end

      def authenticate_token
        if @account_token.present?
          render json: { token: encode({ id: @account_token.id }) }
        else
          render json: { error: 'Please create the API from the main portal' }, status: :unauthorized
        end
      end
    end
  end
end
