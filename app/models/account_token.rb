# frozen_string_literal: true

class AccountToken < ApplicationRecord
  belongs_to :account

  validates :scope, presence: true, uniqueness: { scope: :account_id }

  enum :scope, { ai_showcase: 0 }
end
