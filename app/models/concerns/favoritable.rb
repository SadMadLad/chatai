module Favoritable
  extend ActiveSupport::Concern

  included do
    has_many :favorites, as: :favoritable, dependent: :destroy
    has_many :favorited_accounts, through: :favorites, source: :account
  end

  class_methods do
    def favorites(account: nil)
      if account.present?
        Favorite.where(favoritable: all, account:)
      else
        Favorite.where(favoritable: all)
      end
    end

    def favorites_hash(account: nil)
      favorites(account:).pluck(:id, :account_id).to_h
    end
  end
end
