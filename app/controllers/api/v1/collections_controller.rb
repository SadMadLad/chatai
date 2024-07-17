module Api
  module V1
    class CollectionsController < Api::AuthenticatedController
      def index
        @collections = Collection.includes(:tags).all
        @favorites_hash = @account.favorites_hash(Collection)
      end

      def show
        @collection = Collection.find(params[:id])

        @flash_cards = @collection.flash_cards
        @collections = @collection.collections
        @quizzes = @collection.quizzes
      end
    end
  end
end
