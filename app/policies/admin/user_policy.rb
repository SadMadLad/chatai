# frozen_string_literal: true

module Admin
  # User Policy.
  class UserPolicy < AdminPolicy
    ADMIN_SEPARATION_ACTIONS.each do |action|
      define_method(:"#{action}?") { authenticated? }
    end
  end
end
