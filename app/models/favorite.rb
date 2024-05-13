class Favorite < ApplicationRecord
  belongs_to :account
  belongs_to :favoratable, polymorphic: true
end
