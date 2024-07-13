# frozen_string_literal: true

# Polymorphic Embedding Model that can be utilized with Embeddable Concern Module
class Embedding < ApplicationRecord
  SUPPORTED_EMBEDDABLES = %w[FlashCard Quiz].freeze

  has_neighbors :embedding, dimensions: 768

  belongs_to :embeddable, polymorphic: true

  validates :embeddable_type, presence: true, uniqueness: { scope: :embeddable_id },
                              inclusion: { in: SUPPORTED_EMBEDDABLES }
end
