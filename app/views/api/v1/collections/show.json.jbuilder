# frozen_string_literal: true

json.collection do
  json.partial! 'collection', locals: { collection: @collection, polymorphic_favorites_hash: true }

  json.collections @collections do |collection|
    json.partial! 'collection', locals: { collection:, polymorphic_favorites_hash: true }
  end

  json.flash_cards @flash_cards do |flash_card|
    json.partial! 'api/v1/flash_cards/flash_card', flash_card:, polymorphic_favorites_hash: true
  end

  json.quizzes @quizzes do |quiz|
    json.partial! 'api/v1/quizzes/quiz', quiz:, polymorphic_favorites_hash: true
  end
end
