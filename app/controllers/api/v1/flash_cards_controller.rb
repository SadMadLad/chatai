# frozen_string_literal: true

module Api
  module V1
    class FlashCardsController < Api::AuthenticatedController
      def index
        @flash_cards = FlashCard.all

        render json: @flash_cards.as_json(only: %i[id color answer prompt card_style])
      end
    end
  end
end
