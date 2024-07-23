# frozen_string_literal: true

# Concern with helper methods to use polymorphic embedding model
module Embeddable
  extend ActiveSupport::Concern

  included do
    attr_accessor :skip_embedding_callbacks

    has_one :embedding, as: :embeddable, dependent: :destroy

    after_commit :feed_embedding, on: :create
  end

  def feed_embedding
    return if skip_embedding_callbacks

    CreateEmbeddingWorker.perform_later(self)
  end

  def neighbors(distance: :euclidean)
    instance_embedding = embedding

    neighbor_ids = self.class
                       .all_embeddings
                       .nearest_neighbors(:embedding, instance_embedding.embedding, distance:)
                       .excluding(instance_embedding)
                       .pluck(:embeddable_id)

    self.class.find(neighbor_ids)
  end

  class_methods do
    def all_embeddings
      Embedding.where(embeddable_type: to_s)
    end

    def neighbors(search_embedding, limit: 5, distance: :euclidean)
      neighbor_ids = all_embeddings
                      .nearest_neighbors(:embedding, search_embedding, distance:)
                      .limit(limit)
                      .pluck(:embeddable_id)

      where(id: neighbor_ids).in_order_of(:id, neighbor_ids)
    end

    def embeddable_text(*args, &block)
      options = args.extract_options!

      embeddable_column = options[:column]
      embeddable_columns = options[:columns]

      define_method(:embeddable_text) do
        return instance_exec(&block) if block
        return self[embeddable_column] if embeddable_column.present?
        return embeddable_columns.map { |col| self[col] }.join(' ') if embeddable_columns.present?
      end
    end

    def embeddings
      Embedding.where(embeddable: all)
    end
  end
end
