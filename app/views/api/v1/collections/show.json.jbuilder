# frozen_string_literal: true

json.collection do
  json.id @collection.id

  json.color @collection.color
  json.description @collection.description
  json.favorited @favorites_hash[[@collection.id, 'Collection']].present?
  json.favorites_count @collection.favorites_count
  json.items_count @collection.items_count
  json.title @collection.title

  json.collections @collections do |collection|
    json.id collection.id

    json.color collection.color
    json.description collection.description
    json.favorited @favorites_hash[[collection.id, 'Collection']].present?
    json.favorites_count collection.favorites_count
    json.items_count collection.items_count
    json.title collection.title

    json.tags collection.tags.filter(&:display?) do |tag|
      json.tag tag.tag
    end
  end

  json.flash_cards @flash_cards do |flash_card|
    json.id flash_card.id

    json.answer flash_card.answer
    json.favorited @favorites_hash[[flash_card.id, 'FlashCard']].present?
    json.card_style flash_card.card_style
    json.color flash_card.color
    json.prompt flash_card.prompt

    json.tags flash_card.tags.filter(&:display?) do |tag|
      json.tag tag.tag
    end
  end

  json.quizzes @quizzes do |quiz|
    json.id quiz.id

    json.cover_url quiz.cover.attached? ? rails_blob_url(quiz.cover) : nil
    json.description quiz.description
    json.favorited @favorites_hash[[quiz.id, 'Quiz']].present?
    json.questions_count quiz.questions_count
    json.quiz_undertakings_count quiz.quiz_undertakings_count
    json.ratings_count quiz.ratings_count
    json.timed quiz.timed?
    json.timer quiz.timer
    json.title quiz.title
    json.total_rating quiz.total_rating
    json.total_score quiz.total_score

    json.tags quiz.tags.filter(&:display?) do |tag|
      json.tag tag.tag
    end
  end

  json.tags @tags.filter(&:display?) do |tag|
    json.tag tag.tag
  end
end
