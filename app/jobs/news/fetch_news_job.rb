# frozen_string_literal: true

# TODO: Integrate selenium webdriver support for fetching more news (by scrolling down in the browser)
# https://stackoverflow.com/questions/25997878/can-we-use-mechanize-and-selenium-webdriver-together-ruby
module News
  class FetchNewsJob < ApplicationJob
    include UrlHelper

    BING_NEWS_SEARCH = 'https://www.bing.com/news/search'
    USER_AGENT_ALIASES = Mechanize::AGENT_ALIASES.keys.excluding('Mechanize')

    def perform(query)
      prepare_driver(query)
      scroll_to_bottom(3)
      news_cards_data = fetch_news_cards_data
      @driver.quit

      news_cards_data
    end

    private

    def prepare_driver(query)
      options, browser = randomized_setup
      url = build_query_url(base_url: BING_NEWS_SEARCH, query_hash: { q: query })

      @driver = Selenium::WebDriver.for(browser, options:)
      @driver.get(url)
    end

    def scroll_to_bottom(how_many)
      how_many.times do
        @driver.execute_script('window.scrollTo(0, document.body.scrollHeight)')
        sleep 1
      end
    end

    def fetch_news_cards_data
      news_cards = Nokogiri::HTML(@driver.page_source).css('.news-card')
      news_cards.map do |news_card|
        title = news_card.css('.title').text
        text = news_card.css('.snippet').text
        associated_link = news_card['data-url']

        { title:, text:, associated_link: }
      end
    end

    def randomized_setup
      [
        [Selenium::WebDriver::Firefox::Options.new(args: ['--headless']), :firefox],
        [Selenium::WebDriver::Chrome::Options.new(args: ['--headless']), :chrome]
      ].sample
    end
  end
end
