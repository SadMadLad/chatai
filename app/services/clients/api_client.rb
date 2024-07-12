# frozen_string_literal: true

module Clients
  # Api Client to connect to FastAPI app.
  class ApiClient < Clients::ApplicationClient
    def initialize
      super

      @client = Faraday.new(
        url: ENV.fetch('API_CLIENT_URL', nil),
        headers: {
          'Content-Type' => 'application/json',
          'Authorization' => "Bearer #{ENV.fetch('API_CLIENT_SECRET', nil)}"
        }
      ) do |faraday|
        faraday.response :logger # log requests and responses
        faraday.adapter Faraday.default_adapter
      end
    end

    def autocomplete(messages)
      @client.post('chats/autocomplete', messages.to_json(only: %i[role content]))
    end

    def embedding(texts)
      single_text = texts.is_a?(Array) ? texts.one? : true
      input_texts = texts.is_a?(Array) ? texts : [texts]

      response = JSON.parse @client.post('embeddings', input_texts.to_json).body
      single_text ? response.first : response
    end

    def prediction(ml_model, prediction_params)
      return if ml_model.nil?

      @client.post("ml_models/#{ml_model.id}/prediction", prediction_params.to_json)
    end
  end
end
