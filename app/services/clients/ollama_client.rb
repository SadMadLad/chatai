module Clients
  class OllamaClient < Clients::ApplicationClient
    AVAILABLE_MODELS = %w[moondream:latest gemma2:2b phi3:latest].freeze
    OLLAMA_ENDPOINT = 'http://localhost:11434'
    DEFAULT_PREFERRED_MODEL = 'phi3:latest'

    attr_reader :model

    def initialize(**opts)
      credentials = {
        address: opts[:address] || OLLAMA_ENDPOINT,
        bearer_token: opts[:bearer_token],
      }

      options = opts[:options] || {}

      @client = Ollama.new(credentials:, options:)
      @model = opts[:model] || DEFAULT_PREFERRED_MODEL
    end

    def chat(messages:, system_prompt_key: nil, stream: false)
      raise Ollama::ModelNotFound unless model.in? AVAILABLE_MODELS

      system_prompt = PROMPTS[system_prompt_key]
      messages = [{ role: 'assistant', content: system_prompt }] + messages if system_prompt.present?

      @client.chat({ model:, messages:, stream: })
    end

    def general_single_chat_message(message_content, system_prompt_key: nil)
      chat(
        messages: [{ role: 'user', content: message_content }],
        system_prompt_key:
      )
    end
  end
end
