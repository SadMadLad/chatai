class Embedding < ApplicationRecord
  has_neighbors :embedding, dimensions: 768

  belongs_to :embeddable, polymorphic: true
end
