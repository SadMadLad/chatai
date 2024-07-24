# frozen_string_literal: true

json.id quiz.id

json.cover_url quiz.cover.attached? ? rails_blob_url(quiz.cover) : nil
json.description quiz.description
json.favorited @favorites_hash[polymorphic_favorites_hash ? [quiz.id, 'Quiz'] : quiz.id].present?
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
