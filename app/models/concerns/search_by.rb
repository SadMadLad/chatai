# frozen_string_literal: true

# Ransack inspired small module to search by columns.
module SearchBy
  extend ActiveSupport::Concern

  included do
    columns.each do |column|
      column_type = column.sql_type_metadata.type
      column_name = column.name

      next unless column_type.in? %i[integer datetime boolean string]

      define_singleton_method(:"search_by_#{column_name}") do
        if column_type == :boolean
          return all unless any_param_exists? [:"#{column_name}_is"]

          where(column_name.to_sym => @params[:"#{column_name}_is"])
        elsif column_type == :string
          key_symbol = :"#{column_name}_like"
          return all unless any_param_exists? [key_symbol]

          string_search_query = "%#{sanitize_sql_like @params[key_symbol]}%"
          where("LOWER(#{column_name}) ILIKE ?", string_search_query)
        else
          return all unless any_param_exists? [:"min_#{column_name}", :"max_#{column_name}"]

          where(column_name.to_sym => @params[:"min_#{column_name}"]..@params[:"max_#{column_name}"])
        end
      end
    end
  end
end
