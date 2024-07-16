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
# Polymorphic Embedding Model that can be utilized with Embeddable Concern Module
class Embedding < ApplicationRecord
  SUPPORTED_EMBEDDABLES = %w[FlashCard Quiz].freeze

  has_neighbors :embedding, dimensions: 768

  belongs_to :embeddable, polymorphic: true

  validates :embeddable_type, presence: true, uniqueness: { scope: :embeddable_id },
                              inclusion: { in: SUPPORTED_EMBEDDABLES }
end
