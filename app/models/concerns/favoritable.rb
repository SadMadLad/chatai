module Favoritable
  extend ActiveSupport::Concern

  included do
    has_many :favorites, as: :favoritable, dependent: :destroy
    has_many :favorited_accounts, through: :favorites, source: :account
  end

  class_methods do
    def favorites
      Favorite.where(favoritable_type: self.to_s)
    end
  end
end
