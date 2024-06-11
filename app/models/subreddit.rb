# frozen_string_literal: true

# A reddit subreddit
class Subreddit < ApplicationRecord
  has_many :subreddit_posts, dependent: :destroy

  validates :latest_scraped_at, presence: true, on: :update
  validates :subreddit, presence: true, uniqueness: true
  validates :subreddit_url, presence: true, uniqueness: true,
            format: { with: %r{https://www\.reddit\.com/r/[a-zA-Z0-9_]+} }
end
