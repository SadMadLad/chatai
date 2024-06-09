# frozen_string_literal: true

# Validator to make sure that the attribute is a single word.
#
# e.g:
# Usage:
#
# class Model < ApplicationRecord
#   validates :field, single_word: true
# end
#
# model.field = "Aabc 123"
# model.valid? # false
#
# model.field = "aabc_123"
# model.valid? # true
class SingleWordValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return if value&.split&.length == 1

    record.errors.add(attribute, options[:message] || 'should be a single word')
  end
end
