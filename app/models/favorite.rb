# frozen_string_literal: true

# Favorited things by a user.
class Favorite < ApplicationRecord
  belongs_to :account
  belongs_to :favoratable, polymorphic: true
end
