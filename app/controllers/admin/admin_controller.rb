# frozen_string_literal: true

module Admin
  class AdminController < ApplicationController
    layout 'admin'

    before_action :authenticate_admin!
    before_action :set_new_admin_comment

    protected

    def set_new_admin_comment
      @admin_comment = AdminComment.new
    end

    def fetch_admin_comments(resource)
      @admin_comments = AdminComment
                        .includes(:commenter)
                        .where(admin_commentable: resource)
                        .search_comments_of_resource(admin_comments_search_params)
      @pagy, @admin_comments = pagy(@admin_comments)
      @admins = Account.admins
    end

    def admin_comments_search_params
      params.require(:admin_comments_q).permit(*AdminComment::ADMIN_COMMENTS_Q_PARAMS) if params[:admin_comments_q]
    end

    def authenticate_admin!
      user = authenticate_user!

      head :not_found unless user.account.can_moderate?

      user
    end
  end
end
