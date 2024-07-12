class CreateEmbeddingWorker < ApplicationJob
  queue_as :default

  rescue_from Faraday::ConnectionFailed, with: -> { logger('job_errors.connection_failed') }
  rescue_from Faraday::TimeoutError, with: -> { logger('job_errors.timeout_error') }

  def perform(embeddable)
    has_embedding_already = embeddable.embedding.present?
    new_embedding = Clients::ApiClient.new.embedding(embeddable.embeddable_text)

    if has_embedding_already
      embedding = embeddable.embedding
      embedding.update(embedding: new_embedding)
    else
      Embedding.create(embeddable:, embedding: new_embedding)
    end
  end
end
