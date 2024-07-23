# frozen_string_literal: true

json.array! @quizzes do |quiz|
  json.partial! 'quiz', quiz:, polymorphic_favorites_hash: false
end
