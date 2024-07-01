# frozen_string_literal: true

module Api
  module V1
    # Controller to manage quiz undertakings
    class QuizUndertakingsController < Api::AuthenticatedController
      before_action :set_quiz, only: %i[new create]

      def new
        @questions = @quiz.questions.includes(:question_options, { picture_attachment: :blob })
      end

      def create
        score = @quiz.score_selected_options(formatted_quiz_undertaking_params)
        @questions = @quiz.questions.includes(:question_options, { picture_attachment: :blob })
        @quiz_undertaking = QuizUndertaking.create(correct_answers: score, quiz: @quiz, account: @account)
      end

      private

      def set_quiz
        @quiz = Quiz.find(params[:quiz_id])
      end

      def quiz_undertaking_params
        @quiz_undertaking_params ||= params
                                     .require(:quiz_undertaking)
                                     .permit(selected_options: [:id, :selected, { selected: [] }])
      end

      def formatted_quiz_undertaking_params
        undertaking_params = {}

        quiz_undertaking_params[:selected_options].each do |option|
          undertaking_params[option[:id]] = option[:selected]
        end

        undertaking_params
      end
    end
  end
end
