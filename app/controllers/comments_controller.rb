class CommentsController < AuthenticatedController
  before_action :set_comment, only: %i[edit update]
  before_action :authorize_comment, except: :reply

  def index
    @comments = current_account.comments
  end

  def reply
    @comment = Comment.new(comment_params)
  end

  def create
    @comment = Comment.new(comment_params)
    @commentable = @comment.commentable
    @created = @comment.save
  end

  def edit
    @comment.depth = params.dig(:comment, :depth)
  end

  def update
    if @comment.update(comment_params)
      @like = current_account.likes.find_by(likeable: @comment)
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

  def set_comment
    @comment = Comment.includes(:likes, :replies, { account: { avatar_attachment: :blob } }).find(params[:id])
  end
end
