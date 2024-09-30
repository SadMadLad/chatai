module News
  class GoogleNewsRssJob < ApplicationJob
    include UrlHelper

    GOOGLE_NEWS_RSS_URL = 'https://news.google.com/rss/search'
    MAPPER = { headline: :title, description: :description, associated_link: :link }.freeze
    COUNTRY_SHORT_CODES = %w[CA].freeze


    def perform(query)
      fetch_news_items(query)
    end

    private

    def fetch_news_items(query)
      country_short_code = COUNTRY_SHORT_CODES.sample
      news_url = build_query_url(
        base_url: GOOGLE_NEWS_RSS_URL,
        query_hash: {
          q: query,
          hl: "en-#{country_short_code}",
          gl: country_short_code,
          ceid: "#{country_short_code}:en",
        }
      )
      response = Faraday.get(news_url)

      Hash
        .from_xml(response.body)
        .dig('rss', 'channel', 'item')
        .map do |news_item|
          news_item['description'] = Nokogiri::HTML(news_item['description']).text.squish
          temp_hash = news_item.with_indifferent_access.except(:guid, :pubDate, :source)

          HashMapper.new(temp_hash, MAPPER).parse
        end
    end
  end
end
