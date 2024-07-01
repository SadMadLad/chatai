# frozen_string_literal: true

# Validator to make sure that the attribute has a boolean value.
#
# e.g:
# Usage:
#
# class Model < ApplicationRecord
#   validates :field, boolean: true
# end
#
# model.field = null
# model.valid? # false
#
# model.field = true
# model.valid? # true
class BooleanValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return if value.in?([true, false])

    record.errors.add(attribute, options[:message] || 'should be either true or false.')
  end
end
