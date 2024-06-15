# frozen_string_literal: true

json.quiz do
  json.id @quiz.id
  json.title @quiz.title
  json.description @quiz.description
  json.timed @quiz.timed
  json.timer @quiz.timer
  json.questions_count @quiz.questions.length
  json.cover_url rails_blob_url(@quiz.cover) if @quiz.cover.attached?
end
