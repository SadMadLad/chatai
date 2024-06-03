# frozen_string_literal: true

# The dashboard feed for the user.
class DashboardController < AuthenticatedController
  def index
    @account_tokens = current_account.account_tokens
    @posts = Post.eager_load_everything(without_replies: false).all
    @account_stats = current_account.account_stats
    @current_account_post_and_likes = Like.account_likes_hash('Post', current_account)
  end
end
