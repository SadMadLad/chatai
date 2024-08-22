# frozen_string_literal: true

module Api
  module V1
    # Controller to manage collections
    class CollectionsController < Api::AuthenticatedController
      def index
        @collections = Collection.where(public: true).includes(:tags)
        @favorites_hash = current_account.favorites_hash(Collection)
      end

      def show
        @collection = Collection.find(params[:id])

        @collections = @collection.collections.includes(:tags)
        @flash_cards = @collection.flash_cards.includes(:tags)
        @quizzes = @collection.quizzes.includes(:tags, { cover_attachment: :blob })

        collectables = @collections + @flash_cards + @quizzes + [@collection]
        @favorites_hash = current_account.polymorphic_favorites_hash(collectables)
      end

      def create
        @collection = Collection.new(collection_params)

        if @collection.save
          render json: @collection, status: :created
        else
          render json: @collection.errors.full_messages, status: :unprocessable_entity
        end
      end

      private

      def collection_params
        params.require(:collection).perimit(:title, :description)
      end
    end
  end
end
