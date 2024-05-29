# frozen_string_literal: true

module Admin
  # Admin Dashboard for Posts
  class PostsController < Admin::AdminController
    before_action :set_post, only: %i[show edit update destroy]
    before_action :authorize_post

    before_action -> { define_model_name('post') }
    before_action -> { fetch_admin_comments(@post) }, only: :show

    def index
      @pagy, @posts = pagy(Post.all)
    end

    def show; end

    def new
      @post = Post.new
    end

    def create
      @post = Post.new(post_params)

      if @post.save
        redirect_to [:admin, @post], notice: t(:create, model:)
      else
        render :new, status: :unprocessable_entity, alert: t(:failed_create, model:)
      end
    end

    def edit; end

    def update
      if @post.update(post_params)
        redirect_to [:admin, @post], notice: t(:update, model:)
      else
        render :edit, status: :unprocessable_entity, alert: t(:failed_update, model:)
      end
    end

    def destroy
      @post.destroy
      redirect_to %i[admin posts], notice: t(:destroy, model:)
    end

    private

    def post_params
      params.require(:post).permit(:title, :body, images: [])
    end

    def set_post
      @post = Post.find(params[:id])
    end

    def authorize_post
      authorize @post, policy_class: Admin::AdminPolicy
    end
  end
end
