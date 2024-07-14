# frozen_string_literal: true

module Api
  module V1
    # Controller for flash cards.
    class FlashCardsController < Api::AuthenticatedController
      def index
        @flash_cards = FlashCard.includes(:tags).all.order(:created_at)
        @favorites_hash = @account.favorites_hash(FlashCard)
      end
    end
  end
end
