# frozen_string_literal: true

json.array! @collections do |collection|
  json.id collection.id

  json.description collection.description
  json.favorited @favorites_hash[collection.id].present?
  json.items_count collection.collectable_maps_count
  json.title collection.title

  json.tags collection.tags do |tag|
    json.tag tag.tag
    json.tag_type tag.tag_type
  end
end
