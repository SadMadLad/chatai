# frozen_string_literal: true

module Admin
  # Admin View for Subreddit Posts
  class SubredditPostsController < Admin::AdminController
    before_action :set_subreddit_post, only: %i[show destroy]
    before_action :authorize_subreddit_post

    before_action -> { define_model_name('subreddit post') }
    before_action -> { fetch_admin_comments(@subreddit_post) }, only: :show

    def index
      @pagy, @subreddit_posts = pagy(SubredditPost.all)
    end

    def show; end

    def destroy
      @subreddit_post.destroy
      redirect_to %i[admin subreddit_posts], notice: t(:destroy, model:)
    end

    private

    def set_subreddit_post
      @subreddit_post = SubredditPost.find(params[:id])
    end

    def authorize_subreddit_post
      authorize @subreddit_post, policy_class: Admin::AdminPolicy
    end
  end
end
