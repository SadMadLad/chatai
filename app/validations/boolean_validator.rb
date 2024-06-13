# frozen_string_literal: true

class BooleanValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return if value.in?([true, false])

    record.errors.add(attribute, options[:message] || 'should be either true or false.')
  end
end
