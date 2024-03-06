# frozen_string_literal: true

module Admin
  class AccountPolicy < AdminPolicy
    ADMIN_SEPARATION_ACTIONS.each do |action|
      define_method(:"#{action}?") { authenticated? }
    end
  end
end