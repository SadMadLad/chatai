# frozen_string_literal: true

json.array! @collections do |collection|
  json.partial! 'collection', locals: { collection:, polymorphic_favorites_hash: false }
end
