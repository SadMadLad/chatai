# frozen_string_literal: true

# == Schema Information
#
# Table name: subreddits
#
#  id                    :bigint           not null, primary key
#  subreddit_subscribers :integer
#  subreddit             :string           not null
#  subreddit_url         :string           not null
#  latest_scraped_at     :datetime
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#
class Subreddit < ApplicationRecord
  has_many :subreddit_posts, dependent: :destroy

  validates :latest_scraped_at, presence: true, on: :update
  validates :subreddit, presence: true, uniqueness: true
  validates :subreddit_url, presence: true, uniqueness: true,
                            format: { with: %r{https://www\.reddit\.com/r/[a-zA-Z0-9_]+} }
end
