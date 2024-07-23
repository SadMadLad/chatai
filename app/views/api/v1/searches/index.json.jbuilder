json.recommendations do
  json.flash_cards @flash_cards do |flash_card|
    json.partial! 'api/v1/flash_cards/flash_card', flash_card:, polymorphic_favorites_hash: true
  end

  json.quizzes @quizzes do |quiz|
    json.partial! 'api/v1/quizzes/quiz', quiz:, polymorphic_favorites_hash: true
  end
end
