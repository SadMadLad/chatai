# frozen_string_literal: true

json.array! @quizzes do |quiz|
  json.id quiz.id
  json.timed quiz.timed
  json.timer quiz.timer
  json.title quiz.title
  json.description quiz.description
  json.cover_url quiz.cover.attached? ? rails_blob_url(quiz.cover) : nil
end
