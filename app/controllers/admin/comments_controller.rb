# frozen_string_literal: true

module Admin
  # Admin Controller for Comments
  class CommentsController < Admin::AdminController
    before_action :set_comment, only: %i[show destroy]
    before_action :authorize_comment

    before_action -> { define_model_name('comment') }
    before_action -> { fetch_admin_comments(@comment) }, only: :show

    def index
      @pagy, @comments = pagy(Comment.all)
    end

    def show; end

    def destroy
      @comment.destroy
      redirect_to %i[admin comments], notice: t(:destroy, model:)
    end

    private

    def set_comment
      @comment = Comment.find(params[:id])
    end

    def authorize_comment
      authorize @comment, policy_class: Admin::AdminPolicy
    end
  end
end
