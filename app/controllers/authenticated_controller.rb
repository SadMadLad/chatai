# frozen_string_literal: true

# Parent Controller for controller that require authentication.
class AuthenticatedController < ApplicationController
  before_action :authenticate_user!
end
