# frozen_string_literal: true

module Clients
  class ApiClient
    attr_reader :client

    def initialize(ml_model: nil)
      @client = Faraday.new(
        url: ENV.fetch('API_CLIENT_URL', nil),
        headers: {
          'Content-Type' => 'application/json',
          'Authorization' => "Bearer #{ENV.fetch('API_CLIENT_SECRET', nil)}"
        }
      )
      @ml_model = ml_model
    end

    def prediction(prediction_params)
      return if @ml_model.nil?

      @client.post("ml_models/#{@ml_model.id}/prediction", prediction_params.to_json)
    end

    def autocomplete(messages)
      @client.post('chats/autocomplete', messages.to_json(only: %i[role content]))
    end
  end
end
