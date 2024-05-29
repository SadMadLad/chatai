# frozen_string_literal: true

# Account Policy.
class AccountPolicy < ApplicationPolicy
  def index
    true
  end

  %w[show edit update destroy].each do |action|
    define_method(:"#{action}?") { account == record }
  end
end
