# frozen_string_literal: true

# Fetch Subreddit posts from the main page of that subreddit.
class LatestSubredditPostsJob < ApplicationJob
  rescue_from JSON::ParserError, with: -> { log_error('job_errors.json_parse') }
  rescue_from ActiveModel::UnknownAttributeError, with: -> { log_error('job_errors.unknown_attribute') }

  def perform(subreddit)
    @subreddit = subreddit

    listing_data = JSON.parse(fetch_page_response.body).with_indifferent_access
    listing_data = listing_data.dig(:data, :children)

    logger.debug "Scraping #{listing_data.size} posts for #{@subreddit.subreddit}"

    recent_most_post = listing_data.first['data'].with_indifferent_access

    process_listing_data(listing_data)
    update_subreddit(recent_most_post[:subreddit_subscribers])
  end

  private

  def fetch_page_response
    Faraday.new(url: "#{@subreddit.subreddit_url}.json").get
  end

  def process_listing_data(listing_data)
    listing_data.each do |listing_post|
      process_listing_post(listing_post.with_indifferent_access)
    end
  end

  def process_listing_post(post)
    post_created_at = post.dig(:data, :created_utc)
    return if post_created_at.blank?

    post_created_at = Time.zone.at(post_created_at)
    return unless post_should_be_scrarped?(post, post_created_at)

    post = post[:data]

    values_to_fetch = SubredditPost.column_names.excluding(%w[id created_at updated_at])
    fetched_values = post.values_at(*values_to_fetch)
    subreddit_post_hash = values_to_fetch.zip(fetched_values).to_h.merge('subreddit_id' => @subreddit.id)

    SubredditPost.create(subreddit_post_hash)
  end

  def post_should_be_created(post, post_created_at)
    post[:kind] == 't3' && (@subreddit.latest_scraped_at.nil? || post_created_at > @subreddit.latest_scraped_at)
  end

  def update_subreddit(subreddit_subscribers)
    @subreddit.update(latest_scraped_at: DateTime.now, subreddit_subscribers:)
  end
  end
