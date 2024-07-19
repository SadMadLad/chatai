# frozen_string_literal: true

json.array! @collections do |collection|
  json.id collection.id

  json.color collection.color
  json.description collection.description
  json.favorited @favorites_hash[collection.id].present?
  json.favorites_count collection.favorites_count
  json.items_count collection.items_count
  json.title collection.title

  json.tags collection.tags.filter(&:display?) do |tag|
    json.tag tag.tag
  end
end
