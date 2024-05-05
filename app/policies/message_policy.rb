# frozen_string_literal: true

# Message Policy.
class MessagePolicy < ApplicationPolicy
  def create?
    true
  end

  %w[edit update destroy].each do |action|
    define_method(:"#{action}?") { message_was_by_the_account? }
  end

  private

  def message_was_by_the_account?
    account.messages.exists?(id: record.id)
  end
end
