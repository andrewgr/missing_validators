# Checks if the value of an attribute is equal to a value or proc result.
#
class EqualityValidator < ActiveModel::EachValidator
  # Checks if an attribute value is equal to a value or proc result.
  #
  # @param [Object] record object to validate
  # @param [String] attribute name of the object attribute to validate
  # @param [Object] value attribute value
  def validate_each(record, attribute, value)
    to = options[:to]

    equal_to_value = to.respond_to?(:call) ? options[:to].call(record) : to

    if value != equal_to_value
      record.errors[attribute] << options.fetch(:message) do
        I18n.t('errors.messages.equality', value: equal_to_value)
      end
    end
  end
end
