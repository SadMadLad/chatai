# frozen_string_literal: true

module Api
  module V1
    # Controller for tags
    class TagsController < Api::AuthenticatedController
      def index
        @tags = Tag.where(tag_type: :display).order(:tag).pluck(:tag)

        render json: @tags
      end
    end
  end
end
