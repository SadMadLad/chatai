# frozen_string_literal: true

# The dashboard feed for the user.
class DashboardController < AuthenticatedController
  def index
    @account_tokens = current_account.account_tokens

    @chats_count = current_account.chats.count
    @messages_count = current_account.messages.count
    @likes_count = current_account.likes.count
    @posts_count = current_account.posts.count
  end
end
