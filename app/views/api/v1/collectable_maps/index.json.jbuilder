# frozen_string_literal: true

json.array! @collections do |collection|
  json.id collection.id

  json.collected @collectable_maps_hash[collection.id].present?
  json.description collection.description
  json.title collection.title
end
