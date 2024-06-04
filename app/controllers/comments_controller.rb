# frozen_string_literal: true

# Polymorphic Comments Controller
class CommentsController < AuthenticatedController
  before_action :authorize_comment, except: %i[edit update reply]

  def index
    @comments = current_account.comments
  end

  def reply
    @comment = Comment.new(comment_params)
  end

  def edit
    @comment = Comment.find(params[:id])
    authorize @comment, policy_class: RecordPolicy

    @comment.depth = params.dig(:comment, :depth)
  end

  def create
    @comment = Comment.new(comment_params)
    @commentable = @comment.commentable
    @created = @comment.save
    @account = @comment.account if @created
  end

  def update
    @comment = Comment.deep_includes.find(params[:id])
    authorize @comment, policy_class: RecordPolicy

    if @comment.update(comment_params)
      @like = current_account.likes.find_by(likeable: @comment)
      @account = @comment.account
      @updated = true
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def comment_params
    params
      .require(:comment)
      .permit(:body, :commentable_type, :commentable_id, :depth)
      .merge(account: current_account)
  end

  def authorize_comment
    authorize @comment, policy_class: RecordPolicy
  end
end
