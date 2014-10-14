# Allows to check if the value of a specific attribute is equal to
# the value of another attribute of an object.
#
class EqualityValidator < ActiveModel::EachValidator
  # Checks if an attribute value is unequal to another attrubute value.
  #
  # @param [Object] record object to validate
  # @param [String] attribute name of the object attribute to validate
  # @param [Object] value attribute value
  def validate_each(record, attribute, value)
    equal_to = options[:to]

    equal_to_value = if equal_to.respond_to?(:call)
      options[:to].call(record)
    else
      record.send(equal_to.to_sym)
    end

    if equal_to.present? && value != equal_to_value
      message = options[:message] || I18n.t('errors.messages.equality', attr: equal_to)
      record.errors[attribute] << message
    end
  end
end
