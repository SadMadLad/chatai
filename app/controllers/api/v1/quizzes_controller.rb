# frozen_string_literal: true

module Api
  module V1
    # Controller to manage quizzes
    class QuizzesController < Api::AuthenticatedController
      before_action :set_quiz, only: :show

      def index
        @quizzes = Quiz.where(published: true)
                       .search_by_params(params[:search].present? ? quiz_search_params : nil)
                       .search_by_tags
                       .pluck(:id)

        @quizzes = Quiz.where(id: @quizzes).includes(:tags, { cover_attachment: :blob }).all
        @favorites_hash = @account.favorites_hash(Quiz)
      end

      def show
        @tags = @quiz.tags
      end

      private

      def quiz_search_params
        params[:search] ||= {}
        params.require(:search).permit(:title_like, tags: [])
      end

      def set_quiz
        @quiz = Quiz.find(params[:id])
      end
    end
  end
end
