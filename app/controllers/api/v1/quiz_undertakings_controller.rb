# frozen_string_literal: true

module Api
  module V1
    # Controller to manage quiz undertakings
    class QuizUndertakingsController < Api::AuthenticatedController
      before_action :set_quiz, only: :new

      def new
        @questions = @quiz.questions.includes(:question_options, { picture_attachment: :blob }).randomize
      end

      def create
        binding.pry
      end

      private

      def set_quiz
        @quiz = Quiz.find(params[:quiz_id])
      end
    end
  end
end
