# frozen_string_literal: true

module Api
  module V1
    class FlashCardsController < Api::AuthenticatedController
      def index
        @flash_cards = FlashCard.includes(:tags).all
      end
    end
  end
end
