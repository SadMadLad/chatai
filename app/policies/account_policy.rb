# frozen_string_literal: true

# Account Policy.
class AccountPolicy < ApplicationPolicy
  %w[index show].each do |action|
    define_method(:"#{action}?") { true }
  end

  %w[edit update destroy].each do |action|
    define_method(:"#{action}?") { account == record }
  end
end
