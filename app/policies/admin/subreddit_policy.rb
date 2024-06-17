# frozen_string_literal: true

module Admin
  # Policy for subreddit admin dashboard
  class SubredditPolicy < Admin::AdminPolicy
    def scrape_subreddit_posts? = account.can_moderate?
  end
end
