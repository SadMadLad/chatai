# == Schema Information
#
# Table name: subreddit_posts
#
#  id                      :bigint           not null, primary key
#  subreddit_id            :bigint           not null
#  num_comments            :integer          not null
#  subreddit_subscribers   :integer          not null
#  ups                     :integer          not null
#  upvote_ratio            :float            not null
#  created_utc             :bigint           not null
#  url                     :string           not null
#  author                  :string           not null
#  author_fullname         :string           not null
#  name                    :string           not null
#  permalink               :string           not null
#  score                   :string           not null
#  subreddit_name_prefixed :string           not null
#  title                   :string           not null
#  selftext                :text
#  selftext_html           :text
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#
require "test_helper"

class SubredditPostTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
