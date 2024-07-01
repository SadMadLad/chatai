# frozen_string_literal: true

json.quiz do
  json.id @quiz.id

  json.cover_url rails_blob_url(@quiz.cover) if @quiz.cover.attached?
  json.description @quiz.description
  json.ratings_count @quiz.ratings_count
  json.questions_count @quiz.questions.length
  json.quiz_undertakings_count @quiz.quiz_undertakings_count
  json.timed @quiz.timed?
  json.timer @quiz.timer
  json.title @quiz.title
  json.total_rating @quiz.total_rating
end
