# frozen_string_literal: true

# Validator to make sure that the attribute has all its characters downcase.
#
# e.g:
# Usage:
#
# class Model < ApplicationRecord
#   validates :field, downcase: true
# end
#
# model.field = "Aabc"
# model.valid? # false
#
# model.field = "aabc"
# model.valid? # true
class DowncaseValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return if value == value.downcase

    record.errors.add(attribute, options[:message] || 'must have all lowercase characters')
  end
end
