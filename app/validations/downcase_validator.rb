class DowncaseValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return if value == value.downcase

    record.errors.add(attribute, options[:message] || 'must have all lowercase characters')
  end
end
