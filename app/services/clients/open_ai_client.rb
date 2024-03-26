module Clients
  class OpenAiClient < Clients::ApiClient
    COMPLETIONS_ENDPOINT = 'https://api.openai.com/v1/chat/completions'
    GPT_MODEL = 'gpt-3.5-turbo-0125'
    MAX_TOKENS = 400
    TEMPERATURE = 0.25

    def initialize
      @client = Faraday.new(
        url: COMPLETIONS_ENDPOINT,
        headers: {
          'Content-Type' => 'application/json',
          'Authorization' => "Bearer #{ENV.fetch('OPEN_AI_CLIENT', nil)}"
        }
      )
    end

    def autocomplete(messages)
      return if messages.blank?


    end

    private

    def body
      {

      }
    end
  end
end
