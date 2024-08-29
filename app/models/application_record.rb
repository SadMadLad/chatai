# frozen_string_literal: true

# Base Record
class ApplicationRecord < ActiveRecord::Base
  include TimestampQueries

  attr_accessor :skip_broadcast_callbacks, :skip_callbacks

  primary_abstract_class

  has_many :admin_comments, as: :admin_commentable, dependent: :destroy

  class << self
    def any_param_exists?(params_list)
      return false if @params.blank?

      params_list.any? { |key| @params.key?(key) && @params[key].present? }
    end

    def search_by_params(params)
      return all if params.blank?

      @params = params.is_a?(Hash) ? params.with_indifferent_access : params

      supported_col_types = %i[integer datetime boolean string]
      supported_searchable_columns = columns.filter { |col| col.sql_type_metadata.type.in? supported_col_types }
      search_methods = supported_searchable_columns.map { |col| :"search_by_#{col.name}" }

      search_methods.inject(all) do |scope, method|
        scope.send(method)
      end
    end
  end
end
