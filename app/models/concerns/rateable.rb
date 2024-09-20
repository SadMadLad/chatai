# frozen_string_literal: true

# Models using this concern must have a ratings_count and total_rating column
module Rateable
  extend ActiveSupport::Concern

  included do
    has_many :ratings, as: :rateable, dependent: :destroy
  end
end
