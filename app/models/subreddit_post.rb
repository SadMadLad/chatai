# frozen_string_literal: true

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
class SubredditPost < ApplicationRecord
  MUST_PRESENT_FIELDS = %i[permalink created_utc title name upvote_ratio ups score author author_fullname
                           subreddit_name_prefixed num_comments subreddit_subscribers].freeze

  belongs_to :subreddit

  validates(*MUST_PRESENT_FIELDS, presence: true)

  validates :url, presence: true, uniqueness: true
end
