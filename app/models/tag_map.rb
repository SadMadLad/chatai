# frozen_string_literal: true

# Intermediary table between Tag and Models with tags.
class TagMap < ApplicationRecord
  belongs_to :taggable, polymorphic: true
  belongs_to :tag
end
