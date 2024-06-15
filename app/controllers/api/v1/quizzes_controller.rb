# frozen_string_literal: true

module Api
  module V1
    class QuizzesController < Api::AuthenticatedController
      before_action :set_quiz, only: %i[show undertaking]

      def index
        @quizzes = Quiz.where(published: true).includes(cover_attachment: :blob).all
      end

      def show; end

      def undertaking
        @questions = @quiz.questions.includes(:question_options, { picture_attachment: :blob }).randomize
      end

      private

      def set_quiz
        @quiz = Quiz.find(params[:id])
      end
    end
  end
end
