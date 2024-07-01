# frozen_string_literal: true

json.quiz do
  json.id @quiz.id

  json.timed @quiz.timed?
  json.timer @quiz.timer
  json.title @quiz.title

  json.questions @questions do |question|
    json.id question.id

    json.multiple_answers question.multiple_answers?
    json.picture_url rails_blob_url(question.picture) if question.picture.attached?
    json.question_text question.question_text

    json.question_options question.question_options do |question_option|
      json.id question_option.id

      json.option_text question_option.option_text
    end
  end
end
