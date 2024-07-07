module Api
  module V1
    class TagsController < Api::AuthenticatedController
      def index
        @tags = Tag.where(tag_type: :display).pluck(:tag)

        render json: @tags
      end
    end
  end
end
