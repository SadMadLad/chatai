# frozen_string_literal: true

module Admin
  # Admin View for Subreddits
  class SubredditsController < Admin::AdminController
    before_action :set_subreddit, only: %i[show edit update destroy scrape_subreddit_posts]
    before_action :authorize_subreddit

    before_action -> { define_model_name('subreddit') }
    before_action -> { fetch_admin_comments(@subreddit) }, only: :show

    def index
      @pagy, @subreddits = pagy(Subreddit.all)
    end

    def show; end

    def new
      @subreddit = Subreddit.new
    end

    def edit; end

    def create
      @subreddit = Subreddit.new(subreddit_params)

      if @subreddit.save
        redirect_to [:admin, @subreddit], notice: t(:create, model:)
      else
        render :new, status: :unprocessable_entity, alert: t(:failed_create, model:)
      end
    end

    def update
      if @subreddit.update(subreddit_params)
        redirect_to [:admin, @subreddit], notice: t(:update, model:)
      else
        render :edit, status: :unprocessable_entity, alert: t(:failed_update, model:)
      end
    end

    def destroy
      @subreddit.destroy
      redirect_to %i[admin subreddits], notice: t(:destroy, model:)
    end

    def scrape_subreddit_posts
      LatestSubredditPostsJob.perform_now(@subreddit.id)

      flash[:notice] = t(:job_enqueued)
      head :accepted
    end

    private

    def subreddit_params
      params.require(:subreddit).permit(:subreddit, :subreddit_url)
    end

    def set_subreddit
      @subreddit = Subreddit.find(params[:id])
    end

    def authorize_subreddit
      authorize @subreddit, policy_class: Admin::SubredditPolicy
    end
  end
end
