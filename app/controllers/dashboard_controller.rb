# frozen_string_literal: true

# The dashboard feed for the user.
class DashboardController < AuthenticatedController
  def index
    @account_tokens = current_account.account_tokens
    @chats_count = current_account.chats.count

    messages = current_account.messages
    @messages_count = messages.count
    @latest_message = messages.last
  end
end
