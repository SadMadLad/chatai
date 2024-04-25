# frozen_string_literal: true

module Reddit
  class LatestSubredditPostsJob < ApplicationJob
    rescue_from JSON::ParserError, with: :log_json_parse_error
    rescue_from ActiveModel::UnknownAttributeError, with: :log_unknown_attribute_error

    def perform(subreddit)
      @subreddit = subreddit

      listing_data = JSON.parse(fetch_page_response.body).with_indifferent_access
      listing_data = listing_data.dig(:data, :children)

      logger.debug "Scraping #{listing_data.size} posts for #{@subreddit.subreddit}"

      recent_most_post = listing_data.first['data'].with_indifferent_access
      listing_data.each { |listing_post| process_listing_post(listing_post.with_indifferent_access) }

      @subreddit.update(latest_scraped_at: DateTime.now,
                        subreddit_subscribers: recent_most_post[:subreddit_subscribers])
    end

    def log_json_parse_error
      logger.error "Scraping failed. Could not parse for #{@subreddit.subreddit_url}"
    end

    def log_unknown_attribute_error
      logger.error 'Scraping failed. Unknown attributes detected. Maybe there\'s a change in API?'
    end

    private

    def fetch_page_response
      Faraday.new(url: "#{@subreddit.subreddit_url}.json").get
    end

    def process_listing_post(post)
      post_created_at = post.dig(:data, :created_utc)
      return if post_created_at.blank?

      post_created_at = Time.zone.at(post_created_at)
      return unless post[:kind] == 't3' &&
                    (@subreddit.latest_scraped_at.nil? || post_created_at > @subreddit.latest_scraped_at)

      post = post[:data]

      values_to_fetch = Apis::Reddit::SubredditPost.column_names.excluding(%w[id created_at updated_at])
      fetched_values = post.values_at(*values_to_fetch)
      subreddit_post_hash = values_to_fetch.zip(fetched_values).to_h.merge('subreddit_id' => @subreddit.id)

      Apis::Reddit::SubredditPost.create(subreddit_post_hash)
    end
  end
end
