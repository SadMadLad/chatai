# frozen_string_literal: true

# The dashboard feed for the user.
class DashboardController < AuthenticatedController
  def index
    @account_tokens = current_account.account_tokens
    @posts = Post.eager_load_everything.all
    @count_data = current_account.account_data
    @current_account_post_and_likes = Like.account_likes_hash('Post', current_account)
  end
end
