class CreateEmbeddingWorker < ApplicationJob
  queue_as :default

  rescue_from Faraday::ConnectionFailed, with: -> { logger('job_errors.connection_failed') }
  rescue_from Faraday::TimeoutError, with: -> { logger('job_errors.timeout_error') }

  def perform(embeddable)
    previous_embedding = embeddable.embedding
    new_embedding = Clients::ApiClient.new.embedding(embeddable.embeddable_text)

    if previous_embedding.present?
      previous_embedding.update(embedding: new_embedding)
    else
      Embedding.create(embeddable:, embedding: new_embedding)
    end
  end
end
