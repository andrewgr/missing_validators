# Allows to check if the value of a specific attribute is equal to another value
#
class IsEqualValidator < ActiveModel::EachValidator
  #
  # @param [Object] record object to validate
  # @param [String] attribute name of the object attribute to validate
  # @param [Object] value checks against this value
  def validate_each(record, attribute, value)
    equal_to_value = options[:to]
    if equal_to_value && value != equal_to_value
      message = options[:message] || I18n.t('errors.messages.is_equal', value: equal_to_value)
      record.errors[attribute] << message
    end
  end
end
