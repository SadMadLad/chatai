class AccountPolicy < ApplicationPolicy
  %w[show edit update destroy].each do |action|
    define_method(:"#{action}?") { account == record }
  end
end
