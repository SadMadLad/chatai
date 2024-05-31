class PostsController < AuthenticatedController
  before_action :set_post, only: %i[show edit update destroy]
  before_action :authorize_post, only: %i[edit update destroy]

  def index
    @posts = Post.all
  end

  def own
    @posts = current_account.posts
  end

  def show
    @account = @post.account
    @like = @post.likes.find_by(account: current_account)
    @likes_count = @post.likes.count
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)

    if @post.save
      redirect_to @post, notice: 'Post was successfully created.'
    else
      render :new, status: :unprocessable_entity, alert: 'Could\'nt create the post'
    end
  end

  def edit; end

  def update
    if @post.update(post_params)
      redirect_to @post, notice: 'Post was successfully updated.'
    else
      render :edit, status: :unprocessable_entity, alert: 'Couldn\'t update the post'
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path
  end

  private

  def set_post
    @post = Post.includes(images_attachments: :blob).includes(:likes).find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :body, images: []).merge(account: current_account)
  end
end
