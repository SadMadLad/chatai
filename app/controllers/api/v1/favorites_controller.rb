module Api
  module V1
    class FavoritesController < Api::AuthenticatedController
      def create
        @favorite = Favorite.new(favorite_params)

        if @favorite.save
          render json: @favorite
        else
          render json: @favorite.errors.full_messages, status: :unprocessable_entity
        end
      end

      def destroy
        @favorite = Favorite.find(params[:id])
        @favorite.destroy
      end

      private

      def favorite_params
        params.require(:favorite).permit(:favoritable_type, :favoritable_id).merge(account: current_account)
      end
    end
  end
end
