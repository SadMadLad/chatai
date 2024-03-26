# frozen_string_literal: true

module Clients
  class OpenAiClient
    attr_reader :client

    COMPLETIONS_ENDPOINT = 'https://api.openai.com/v1/chat/completions'
    GPT_MODEL = 'gpt-3.5-turbo-0125'
    MAX_TOKENS = 400
    TEMPERATURE = 0.25

    def initialize(messages: [])
      @client = Faraday.new(
        url: COMPLETIONS_ENDPOINT,
        headers: {
          'Content-Type' => 'application/json',
          'Authorization' => "Bearer #{ENV.fetch('OPEN_AI_CLIENT', nil)}"
        }
      )
      @messages = messages
    end

    def autocomplete(messages)
      return if messages.blank?

      @client.post(COMPLETIONS_ENDPOINT, body.to_json)
    end

    private

    def body
      {
        model: GPT_MODEL,
        max_tokens: MAX_TOKENS,
        temperature: TEMPERATURE,
        messages: @messages,
      }
    end
  end
end
