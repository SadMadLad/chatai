# frozen_string_literal: true

# A reddit subreddit
class Subreddit < ApplicationRecord
  has_many :subreddit_posts, dependent: :destroy

  validates :latest_scraped_at, presence: true, on: :update
  validates :subreddit, :subreddit_url, presence: true, uniqueness: true
end
