# frozen_string_literal: true

# Posts Controller
class PostsController < AuthenticatedController
  before_action :set_post, only: %i[show edit update destroy]
  before_action :authorize_post, only: %i[edit update destroy]
  before_action -> { define_model_name('post') }

  def index
    @posts = current_account.posts
  end

  def own
    @posts = current_account.posts
  end

  def show
    @account = @post.account
    @comments = @post.comments.deep_includes.all
    @comment = Comment.new

    @account_comments_likes_hash = Like.account_likes_hash('Comment', current_account)
    @post_like = @post.likes.find_by(account: current_account)
    @likes_count = @post.likes.count
  end

  def edit; end

  def create
    @post = Post.new(post_params)

    if @post.save
      redirect_to @post, notice: t(:create, model:)
    else
      render :new, status: :unprocessable_entity, alert: t(:failed_create, model:)
    end
  end

  def update
    if @post.update(post_params)
      redirect_to @post, notice: t(:update, model:)
    else
      render :edit, status: :unprocessable_entity, notice: t(:failed_update, model:)
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path
  end

  private

  def set_post
    @post = Post.includes(images_attachments: :blob).find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :body, images: []).merge(account: current_account)
  end

  def authorize_post
    authorize @post, policy_class: RecordPolicy
  end
end
