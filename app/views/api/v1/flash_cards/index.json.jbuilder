# frozen_string_literal: true

json.array! @flash_cards do |flash_card|
  json.id flash_card.id

  json.answer flash_card.answer
  json.liked @favorites_hash[flash_card.id].present?
  json.card_style flash_card.card_style
  json.color flash_card.color
  json.prompt flash_card.prompt

  json.tags flash_card.tags do |tag|
    json.tag tag.tag
    json.tag_type tag.tag_type
  end
end
