# frozen_string_literal: true

module Api
  module V1
    class FlashCardsController < Api::AuthenticatedController
      def index
        @flash_cards = FlashCard.includes(:tags).all
        @favorites_hash = FlashCard.favorites(account: @account).pluck(:id, :favoritable_id).to_h
      end
    end
  end
end
