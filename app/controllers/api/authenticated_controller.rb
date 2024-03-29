# frozen_string_literal: true

module Api
  class AuthenticatedController < Api::ApiController
    include JwtService

    before_action :authenticate_account_token!

    def parse_auth_header
      auth_header = request.headers['Authorization']
      return if auth_header.blank?

      split_auth_header = auth_header.split
      bearer = split_auth_header.first
      token = split_auth_header.second

      bearer.blank? || token.blank? || bearer != 'Bearer' ? nil : token
    end

    def authenticate_account_token!
      token = parse_auth_header
      if token.present?
        @account_token = AccountToken.find(decode(token)[:id])
        @account = @account_token.account
      else
        render json: { error: 'Invalid or blank token' }, status: :unauthorized
      end
    rescue StandardError
      render json: { error: 'Could not authenticate user' }, status: :unauthorized
    end
  end
end
