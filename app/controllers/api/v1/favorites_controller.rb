# frozen_string_literal: true

module Api
  module V1
    # Ability to favorite/unfavorite flash cards, quizzes and collections
    class FavoritesController < Api::AuthenticatedController
      def create
        @favorite = Favorite.find_or_create_by(favorite_params)

        if @favorite.save
          render json: @favorite, status: :created
        else
          render json: @favorite.errors.full_messages, status: :unprocessable_entity
        end
      end

      def destroy
        @favorite = Favorite.find_by(favorite_params)
        @favorite.destroy if @favorite.present?
      end

      private

      def favorite_params
        params.require(:favorite).permit(:favoritable_type, :favoritable_id).merge(account: current_account)
      end
    end
  end
end
