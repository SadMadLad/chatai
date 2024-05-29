# frozen_string_literal: true

module Admin
  # Admin Dashboard for Likes
  class LikesController < Admin::AdminController
    before_action :set_like, only: %i[show destroy]
    before_action :authorize_like

    before_action -> { define_model_name('like') }
    before_action -> { fetch_admin_comments(@like) }, only: :show

    def index
      @pagy, @likes = pagy(Like.includes(:likeable))
    end

    def show; end

    def destroy
      @like.destroy
      redirect_to %i[admin likes], notice: t(:destroy, model:)
    end

    private

    def set_like
      @like = Like.find(params[:id])
    end

    def authorize_like
      authorize @like, policy_class: Admin::AdminPolicy
    end
  end
end
