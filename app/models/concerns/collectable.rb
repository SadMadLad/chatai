# frozen_string_literal: true

# Concern for using polymorphic model Collection with CollectableMap
module Collectable
  extend ActiveSupport::Concern

  included do
    has_many :collectable_maps, as: :collectable, dependent: :destroy
    has_many :collections, through: :collectable_maps
    has_many :collected_accounts, through: :collections, source: :account
  end
end
