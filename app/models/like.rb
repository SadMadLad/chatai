# frozen_string_literal: true

# Favorited things by a user.
class Like < ApplicationRecord
  belongs_to :account
  belongs_to :likeable, polymorphic: true

  validates :account_id, uniqueness: { scope: %i[likeable_type likeable_id] }

  class << self
    def account_likes_hash(likeable_type)
      where(likeable_type:).pluck(:likeable_id, :id).to_h
    end
  end
end
