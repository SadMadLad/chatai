# frozen_string_literal: true

module Clients
  class ApiClient
    attr_accessor :client

    def initialize
      @client = Faraday.new(
        url: ENV.fetch('API_CLIENT_URL', nil),
        headers: {
          'Content-Type' => 'application/json',
          'Authorization' => "Bearer #{ENV.fetch('API_CLIENT_SECRET', nil)}"
        }
      )
    end
  end
end
