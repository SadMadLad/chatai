# frozen_string_literal: true

class ChatPolicy < ApplicationPolicy
  %w[index group ai_chats create].each do |action|
    define_method(:"#{action}?") { true }
  end

  %w[show autocomplete details destroy].each do |action|
    define_method(:"#{action}?") { account_chat? }
  end

  private

  def account_chat?
    account.chats.exists?(id: record.id)
  end
end
