# Allows to check if the value of a specific attribute is not equal to another value
#
class IsNotEqualValidator < ActiveModel::EachValidator
  #
  # @param [Object] record object to validate
  # @param [String] attribute name of the object attribute to validate
  # @param [Object] value checks against this value
  def validate_each(record, attribute, value)
    not_equal_to_value = options[:to]
    if value == not_equal_to_value
      message = options[:message] || I18n.t('errors.messages.is_not_equal', value: not_equal_to_value)
      record.errors[attribute] << message
    end
  end
end
