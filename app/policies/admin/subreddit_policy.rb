# frozen_string_literal: true

module Admin
  class SubredditPolicy < Admin::AdminPolicy
    def scrape_subreddit_posts? = account.can_moderate?
  end
end
