# frozen_string_literal: true

json.id flash_card.id

json.answer flash_card.answer
json.favorited @favorites_hash[polymorphic_favorites_hash ? [flash_card.id, 'FlashCard'] : flash_card.id].present?
json.card_style flash_card.card_style
json.color flash_card.color
json.prompt flash_card.prompt

json.tags flash_card.tags.filter(&:display?) do |tag|
  json.tag tag.tag
end
