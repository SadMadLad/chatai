# frozen_string_literal: true

module Api
  module V1
    # Controller for flash cards.
    class FlashCardsController < Api::AuthenticatedController
      def index
        @flash_cards = FlashCard.includes(:tags)
        @favorites_hash = current_account.favorites_hash(FlashCard)
      end
    end
  end
end
