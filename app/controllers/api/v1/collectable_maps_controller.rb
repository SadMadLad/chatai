# frozen_string_literal: true

module Api
  module V1
    # Add / Remove items from collections
    class CollectableMapsController < Api::AuthenticatedController
      before_action :verify_collectable_type, :fetch_collectable_item, only: :index

      def index
        @collections = current_account.collections
        @collectable_maps_hash = CollectableMap
                                 .where(collection: @collections, collectable: @item)
                                 .pluck(:collection_id, :collectable_id)
                                 .to_h
      end

      def create
        @collection_map = CollectableMap.find_or_create_by(collectable_map_params)

        if @collection_map.save
          render json: @collection_map, status: :created
        else
          render json: @collection_map.errors.full_messages, status: :unprocessable_entity
        end
      end

      def destroy
        @collection_map = CollectableMap.find_by(collectable_map_params)
        @collection_map.destroy if @collection_map.present?
      end

      private

      def verify_collectable_type
        head :bad_request unless collectable_map_params[:collectable_type].in? Collection::COLLECTABLE_MODELS
      end

      def fetch_collectable_item
        @item = collectable_map_params[:collectable_type]
                .constantize
                .find(collectable_map_params[:collectable_id])
      end

      def collectable_map_params
        @collectable_map_params ||= params
                                    .require(:collectable_map)
                                    .permit(:collectable_id, :collectable_type, :collection_id)
      end
    end
  end
end
