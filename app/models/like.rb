# frozen_string_literal: true

# == Schema Information
#
# Table name: likes
#
#  id            :bigint           not null, primary key
#  account_id    :bigint           not null
#  likeable_type :string           not null
#  likeable_id   :bigint           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
# Liked things by a user.
class Like < ApplicationRecord
  belongs_to :account
  belongs_to :likeable, polymorphic: true, counter_cache: :likes_count

  validates :account_id, uniqueness: { scope: %i[likeable_type likeable_id] }

  class << self
    def account_likes_hash(likeable_type, account)
      where(likeable_type:, account:).pluck(:likeable_id, :id).to_h
    end
  end
end
