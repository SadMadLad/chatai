# frozen_string_literal: true

module Api
  module V1
    # Controller for flash cards.
    class FlashCardsController < Api::AuthenticatedController
      def index
        @flash_cards = FlashCard.includes(:tags).all.order(:created_at)
        @favorites_hash = @account.favorites.where(favoritable_type: 'FlashCard').pluck(:favoritable_id, :id).to_h
      end
    end
  end
end
