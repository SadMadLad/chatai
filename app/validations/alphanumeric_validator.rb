# frozen_string_literal: true

# Validator to make sure that the attribute is alphanumeric only.
#
# e.g:
# Usage:
#
# class Model < ApplicationRecord
#   validates :field, alphanumeric: true
# end
#
# model.field = "123abc*(*)*()"
# model.valid? # false
#
# model.field = "123abc"
# model.valid? # true
class AlphanumericValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return unless value.match?(/[^a-zA-Z0-9]/)

    record.errors.add(attribute, options[:message] || 'must be alphanumeric only')
  end
end
