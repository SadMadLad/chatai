# frozen_string_literal: true

module Api
  # Methods to authenticate account via the encrypted account token.
  class AuthenticatedController < Api::ApiController
    before_action :authenticate_account_token!
  end
end
