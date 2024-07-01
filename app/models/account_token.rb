# frozen_string_literal: true

# == Schema Information
#
# Table name: account_tokens
#
#  id         :bigint           not null, primary key
#  account_id :bigint           not null
#  scope      :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Generate tokens for accounts for accessing different scopes and platforms.
class AccountToken < ApplicationRecord
  FRONTEND_URL = ENV.fetch('FRONTEND_URL', nil)
  VERSE_URL = ENV.fetch('VERSE_URL', nil)

  belongs_to :account

  validates :scope, presence: true, uniqueness: { scope: :account_id }

  enum :scope, { frontend: 0, verse: 1 }

  def profile_url(account)
    "#{frontend? ? FRONTEND_URL : VERSE_URL}/accounts/#{account.username}/public"
  end
end
