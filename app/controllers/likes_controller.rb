# frozen_string_literal: true

# Likes Controller
class LikesController < AuthenticatedController
  before_action :set_like, only: :destroy
  before_action :authorize_like, only: :destroy

  def index
    @likes = current_account.likes.includes(:likeable)
  end

  def create
    @like = Like.find_or_create_by(like_params)
    @likeable = @like.likeable
  end

  def destroy
    @likeable = @like.likeable
    @like.destroy
  end

  private

  def like_params
    params.require(:like).permit(:likeable_id, :likeable_type).merge(account_id: current_account.id)
  end

  def authorize_like
    authorize @like, policy_class: RecordPolicy
  end

  def set_like
    @like = Like.find_by(id: params[:id])
  end
end
