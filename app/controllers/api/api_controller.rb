# frozen_string_literal: true

module Api
  # Base Controller for API only.
  class ApiController < ActionController::API
    include JwtService
    include Pundit::Authorization

    rescue_from ActiveRecord::RecordNotFound, with: :not_found

    helper_method :current_account

    def pundit_user
      current_account
    end

    attr_reader :current_account

    def authenticate_account_token!
      token = parse_auth_header
      if token.present?
        verify_token(token)
      else
        render json: { error: 'Invalid or empty token' }, status: :unauthorized
      end
    rescue StandardError
      render json: { error: 'Could not authenticate user' }, status: :unauthorized
    end

    def not_found
      render json: { error: 'Record not found' }, status: :not_found
    end

    private

    def parse_auth_header
      auth_header = request.headers['Authorization']
      return if auth_header.blank?

      split_auth_header = auth_header.split
      bearer = split_auth_header.first
      token = split_auth_header.second

      bearer.present? && token.present? && bearer != 'Bearer' ? nil : token
    end

    def verify_token(token)
      decoded_token = decode(token)
      if Time.zone.at(decoded_token[:exp]) <= DateTime.now
        render json: { error: 'Your session has expired' }, status: :unauthorized
      else
        @current_account_token = AccountToken.find(decoded_token[:sub])
        @current_account = @current_account_token.account
      end
    end
  end
end
