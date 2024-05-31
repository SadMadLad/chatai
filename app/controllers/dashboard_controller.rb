# frozen_string_literal: true

# The dashboard feed for the user.
class DashboardController < AuthenticatedController
  def index
    @account_tokens = current_account.account_tokens
    @posts = Post
              .includes(images_attachments: :blob)
              .includes(:likes)
              .includes(:account)
              .all
    @current_account_post_and_likes =
      current_account.likes.where(likeable_type: 'Post').pluck(:likeable_id, :id).to_h

    @chats_count = current_account.chats.count
    @messages_count = current_account.messages.count
    @likes_count = current_account.likes.count
    @posts_count = current_account.posts.count
  end
end
