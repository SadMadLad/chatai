json.id collection.id

json.color collection.color
json.description collection.description
json.favorited @favorites_hash[polymorphic_favorites_hash ? [collection.id, 'Collection'] : collection.id].present?
json.favorites_count collection.favorites_count
json.items_count collection.items_count
json.title collection.title

json.tags collection.tags.filter(&:display?) do |tag|
  json.tag tag.tag
end
