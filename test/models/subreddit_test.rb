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
require "test_helper"

class SubredditTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
