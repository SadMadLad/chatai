# frozen_string_literal: true

# == Schema Information
#
# Table name: embeddings
#
#  id              :bigint           not null, primary key
#  embeddable_type :string           not null
#  embeddable_id   :bigint           not null
#  embedding       :vector(768)      not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class Embedding < ApplicationRecord
  # Embeddables must have: associated tags and favorites_count column.
  SUPPORTED_EMBEDDABLES = %w[FlashCard Quiz].freeze

  has_neighbors :embedding, dimensions: 768

  belongs_to :embeddable, polymorphic: true

  validates :embeddable_type, presence: true, uniqueness: { scope: :embeddable_id },
                              inclusion: { in: SUPPORTED_EMBEDDABLES }

  SUPPORTED_EMBEDDABLES.each do |_embeddable_type|
    define_method(:"of_#{_embeddable_type.underscore}?") { embeddable_type == _embeddable_type }
  end

  class << self
    def polymorphic_neighbors(search_embedding, distance: :euclidean, limit: nil)
      nearest_neighbors(:embedding, search_embedding, distsance:)
        .includes(embeddable: :tags)
        .limit(limit)
    end

    SUPPORTED_EMBEDDABLES.each do |embeddable_type|
      define_method(:"#{embeddable_type.underscore.pluralize}") { where(embeddable_type:) }
    end
  end
end
