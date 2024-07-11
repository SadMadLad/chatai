# frozen_string_literal: true

# == Schema Information
#
# Table name: collections
#
#  id                     :bigint           not null, primary key
#  account_id             :bigint           not null
#  public                 :boolean          default(TRUE), not null
#  collectable_maps_count :integer          default(0), not null
#  favorites_count        :integer          default(0), not null
#  title                  :string           not null
#  description            :text
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
class Collection < ApplicationRecord
  include Collectable
  include Favoritable
  include Taggable

  COLLECTABLE_ITEMS = %w[Collection CollectableMap Quiz]

  belongs_to :account

  has_many :items, dependent: :destroy, class_name: 'CollectableMap'

  COLLECTABLE_ITEMS.each do |model|
    has_many model.downcase.pluralize.to_sym, through: :items, source: :collectable, source_type: model
  end

  validates :public, boolean: true
  validates :title, presence: true
end
