class DateValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    value.present? && Date.parse(value)
  rescue ArgumentError
    record.errors[attribute] << (options[:message] || "is not a date")
  end
end
