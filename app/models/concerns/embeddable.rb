module Embeddable
  extend ActiveSupport::Concern

  included do
    attr_accessor :skip_embedding_callbacks

    has_one :embedding, as: :embeddable, dependent: :destroy
  
    after_commit :feed_embedding, on: %i[create update]
  end

  def feed_embedding
    return if skip_embedding_callbacks

    CreateEmbeddingWorker.perform_later(self)
  end

  class_methods do
    def all_embeddings
      Embedding.where(embeddable_type: self.to_s)
    end

    def embeddable_text(*args, &block)
      options = args.extract_options!

      embeddable_column = options[:column]
      embeddable_columns = options[:columns]

      define_method(:embeddable_text) do
        if block_given?
          instance_exec(&block)
        elsif embeddable_column.present?
          self[embeddable_column]
        else
          embeddable_columns.map{ |col| self[col] }.join(' ')
        end
      end
    end

    def embeddings
      Embedding.where(embeddable: all)
    end
  end
end
