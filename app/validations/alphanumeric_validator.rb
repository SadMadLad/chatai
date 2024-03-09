# frozen_string_literal: true

class AlphanumericValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return unless value.match?(/[^a-zA-Z0-9]/)

    record.errors.add(attribute, options[:message] || 'must be alphanumeric only')
  end
end
