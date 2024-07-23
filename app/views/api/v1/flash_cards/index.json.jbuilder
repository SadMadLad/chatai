# frozen_string_literal: true

json.array! @flash_cards do |flash_card|
  json.partial! 'flash_card', flash_card:, polymorphic_favorites_hash: false
end
