# frozen_string_literal: true

module Apis
  module Reddit
    class Subreddit < ApplicationRecord
      has_many :subreddit_posts, dependent: :destroy

      validates :latest_scraped_at, presence: true, on: :update
      validates :subreddit, :subreddit_url, presence: true
    end
  end
end
