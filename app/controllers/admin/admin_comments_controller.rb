# frozen_string_literal: true

module Admin
  # Admin Dashboard for Admin Comments
  class AdminCommentsController < Admin::AdminController
    before_action :set_admin_comment, only: %i[show edit update destroy]
    before_action :authorize_admin_comment

    before_action -> { define_model_name('admin comment') }
    before_action -> { fetch_admin_comments(@admin_comment) }, only: :show

    def index
      @pagy, @admin_comments = pagy(AdminComment.includes(:admin_commentable).includes(:commenter).all)
    end

    def show; end

    def edit; end

    def create
      @admin_comment = AdminComment.new(admin_comment_params)
      if @admin_comment.save
        redirect_to [:admin, @admin_comment.admin_commentable], notice: t(:create, model:)
      else
        render :new, status: :unprocessable_entity, alert: t(:failed_create, model:)
      end
    end

    def update
      if @admin_comment.update(admin_comment_params)
        render turbo_stream: turbo_stream.replace(
          @admin_comment, partial: 'admin_comment', locals: { admin_comment: @admin_comment }
        )
      else
        render :edit, status: :unprocessable_entity, alert: t(:failed_update, model:)
      end
    end

    def destroy
      @admin_comment.destroy
      redirect_to [:admin, @admin_commentable], notice: t(:destroy, model:)
    end

    private

    def set_admin_comment
      @admin_comment = AdminComment.find(params[:id])
      @admin_commentable = @admin_comment.admin_commentable
    end

    def admin_comment_params
      params
        .require(:admin_comment)
        .permit(:body, :admin_commentable_id, :admin_commentable_type)
        .merge(commenter_id: current_account.id)
    end

    def authorize_admin_comment
      authorize @admin_comment, policy_class: Admin::AdminCommentPolicy
    end
  end
end
