# frozen_string_literal: true

# Generate tokens for accounts for accessing different scopes and platforms.
class AccountToken < ApplicationRecord
  belongs_to :account

  validates :scope, presence: true, uniqueness: { scope: :account_id }

  enum :scope, { frontend: 0, verse: 1 }
end
