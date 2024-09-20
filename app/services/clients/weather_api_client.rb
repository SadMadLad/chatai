# frozen_string_literal: true

module Clients
  # API client to fetch weather report.
  class WeatherApiClient < Clients::ApplicationClient
    WEATHER_API_URL = 'http://api.weatherapi.com/v1'
    AVAILABLE_URLS = %i[current forecast search history marine future timezone sports astronomy ip].freeze

    def initialize
      super

      @client = Faraday.new(
        url: WEATHER_API_URL,
        headers: { 'Content-Type' => 'application/json' }
      )
      @q = { key: ENV.fetch('WEATHER_API_KEY', nil) }
    end

    def query_weather(scope, location, json: true)
      return unless scope.in?(AVAILABLE_URLS)

      @q = @q.deep_merge(q: location)
      @client.get("#{scope}#{json ? '.json' : '.xml'}", @q)
    end
  end
end
