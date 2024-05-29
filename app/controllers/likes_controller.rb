class LikesController < AuthenticatedController
  before_action :set_like, only: :destroy
  before_action :authorize_like, only: :destroy

  def index
    @likes = current_account.likes.includes(:likeable)
  end

  def create
    @like = Like.create(like_params)
    @likeable = @like.likeable
  end

  def destroy
    @like.destroy
  end

  private

  def like_params
    params.require(:like).permit(:likeable_id, :likeable_type).merge(account_id: currenet_account.id)
  end

  def set_like
    @like = Like.find(params[:id])
  end

  def authorize_like
    authorize @like, policy_class: LikePolicy
  end
end
