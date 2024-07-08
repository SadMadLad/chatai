# frozen_string_literal: true

# == Schema Information
#
# Table name: admin_comments
#
#  id                     :bigint           not null, primary key
#  admin_commentable_type :string           not null
#  admin_commentable_id   :bigint           not null
#  commenter_id           :bigint           not null
#  body                   :text             not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
class AdminComment < ApplicationRecord
  ADMIN_COMMENTS_Q_PARAMS = %i[sort_by sort_by_direction commenter_id min_created_at max_created_at min_updated_at
                               max_updated_at].freeze

  belongs_to :admin_commentable, polymorphic: true
  belongs_to :commenter, class_name: 'Account'

  validates :body, presence: true

  class << self
    def search_comments_of_resource(params)
      return all if params.blank?

      @params = params
      search_by_admin
        .search_by_created_at
        .search_by_updated_at
        .sort_by_params
    end

    def any_param_exists?(params_list)
      return false if @params.blank?

      params_list.any? { |key| @params.key?(key) && @params[key].present? }
    end

    def search_by_admin
      return all if @params[:commenter_id].blank?

      where(commenter: { id: @params[:commenter_id] })
    end

    def search_by_created_at
      return all unless any_param_exists? %i[min_created_at min_created_at]

      where(created_at: @params[:min_created_at]..@params[:max_created_at])
    end

    def search_by_updated_at
      return all unless any_param_exists? %i[min_updated_at max_updated_at]

      where(updated_at: @params[:min_updated_at]..@params[:max_updated_at])
    end

    def sort_by_params
      order(@params[:sort_by] || :created_at => @params[:sort_by_direction] || :asc)
    end
  end
end
