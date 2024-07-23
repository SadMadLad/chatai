module Api
  module V1
    class SearchesController < Api::AuthenticatedController
      def index
        if recommendation_search_params[:search_text].blank?
          @flash_cards = FlashCard.includes(:tags).order(favorites_count: :desc)
          @quizzes = Quiz.includes(:tags).order(favorites_count: :desc)
        else
          search_embedding = Clients::ApiClient.new.embedding(recommendation_search_params[:search_text])

          @flash_cards = FlashCard.neighbors(search_embedding).includes(:tags)
          @quizzes = Quiz.neighbors(search_embedding).includes(:tags, { cover_attachment: :blob })
        end

        @favorites_hash = current_account.polymorphic_favorites_hash(@flash_cards + @quizzes)
      end

      private

      def recommendation_search_params
        params[:recommendation_search] ||= {}
        @recommendation_search_params ||= params.require(:recommendation_search).permit(:search_text)
      end
    end
  end
end
