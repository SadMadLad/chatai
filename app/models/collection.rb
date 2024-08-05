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
#  items_count            :integer          default(0), not null
#  color                  :string           not null
#  title                  :string           not null
#  description            :text
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
class Collection < ApplicationRecord
  include ActivityLoggable
  include Collectable
  include Colors
  include Favoritable
  include Taggable

  COLLECTABLE_MODELS = %w[Collection FlashCard Quiz].freeze

  belongs_to :account

  has_many :items, dependent: :destroy, class_name: 'CollectableMap'

  before_create -> { @create_log_text = "Created Collection: #{title}" }
  before_destroy -> { @destroy_log_text = "Deleted Collection: #{title}" }

  COLLECTABLE_MODELS.each do |model|
    has_many model.underscore.pluralize.to_sym, through: :items, source: :collectable, source_type: model
  end

  validates :public, boolean: true
  validates :title, presence: true
end
