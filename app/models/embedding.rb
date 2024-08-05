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
  # The order metters here (in the polymorphic_neighbors class method)
  SUPPORTED_EMBEDDABLES = %w[FlashCard Quiz].freeze

  has_neighbors :embedding, dimensions: 768

  belongs_to :embeddable, polymorphic: true

  validates :embeddable_type, presence: true, uniqueness: { scope: :embeddable_id },
                              inclusion: { in: SUPPORTED_EMBEDDABLES }
  class << self
    def polymorphic_neighbors(search_embedding, distance: :euclidean, limit: nil, include_tags: true)
      where(embeddable_type: Embedding::SUPPORTED_EMBEDDABLES)
        .includes(include_tags ? { embeddable: [tag_maps: :tag] } : :embeddable)
        .nearest_neighbors(:embedding, search_embedding, distance:)
        .limit(limit)
        .group_by(&:embeddable_type)
        .transform_values { |recommendations| recommendations.map(&:embeddable) }
        .values_at(*SUPPORTED_EMBEDDABLES)
    end
  end
end
