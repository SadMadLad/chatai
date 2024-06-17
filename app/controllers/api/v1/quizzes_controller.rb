# frozen_string_literal: true

module Api
  module V1
    # Controller to manage quizzes
    class QuizzesController < Api::AuthenticatedController
      before_action :set_quiz, only: :show

      def index
        @quizzes = Quiz.where(published: true).includes(cover_attachment: :blob).all
      end

      def show; end

      private

      def set_quiz
        @quiz = Quiz.find(params[:id])
      end
    end
  end
end
