# frozen_string_literal: true

# Favorited things by a user.
class Like < ApplicationRecord
  belongs_to :account
  belongs_to :likeable, polymorphic: true
end
