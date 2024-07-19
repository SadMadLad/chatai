# frozen_string_literal: true

module Api
  module V1
    class CollectionsController < Api::AuthenticatedController
      def index
        @collections = Collection.where(public: true).includes(:tags).all
        @favorites_hash = current_account.favorites_hash(Collection)
      end

      def show
        @collection = Collection.find(params[:id])

        @collections = @collection.collections.includes(:tags)
        @flash_cards = @collection.flash_cards.includes(:tags)
        @quizzes = @collection.quizzes.includes(:tags, { cover_attachment: :blob })
        @tags = @collection.tags.where(tag_type: :display)

        @favorites_hash = current_account.polymorphic_favorites_hash(@collections + @flash_cards + @quizzes + [@collection])
      end
    end
  end
end
