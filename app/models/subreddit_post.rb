# frozen_string_literal: true

# Scraped subreddit post for a subreddit
class SubredditPost < ApplicationRecord
  MUST_PRESENT_FIELDS = %i[url permalink created_utc title name upvote_ratio ups score author author_fullname
                           subreddit_name_prefixed num_comments subreddit_subscribers].freeze

  belongs_to :subreddit

  validates(*MUST_PRESENT_FIELDS, presence: true)
end
