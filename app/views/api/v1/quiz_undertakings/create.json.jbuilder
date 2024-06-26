json.score @quiz_undertaking.correct_answers

json.quiz do
  json.id @quiz.id
  json.title @quiz.title
  json.timed @quiz.timed?
  json.timer @quiz.timer

  json.questions @questions do |question|
    json.id question.id
    json.multiple_answers question.multiple_answers?
    json.question_text question.question_text
    json.picture_url rails_blob_url(question.picture) if question.picture.attached?

    json.question_options question.question_options do |question_option|
      json.id question_option.id
      json.option_text question_option.option_text
      json.correct question_option.correct?
    end
  end
end
