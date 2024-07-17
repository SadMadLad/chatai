# frozen_string_literal: true

# Concern for managing polymorphic model - embedding
module Favoritable
  extend ActiveSupport::Concern

  included do
    has_many :favorites, as: :favoritable, dependent: :destroy
    has_many :favorited_accounts, through: :favorites, source: :account
  end

  class_methods do
    def all_favorites
      Favorite.where(favoritable: to_s)
    end
  end
end
