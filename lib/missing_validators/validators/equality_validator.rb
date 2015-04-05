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

    reference_value = to.respond_to?(:call) ? options[:to].call(record) : to

    return if compare_value(value, reference_value)

    record.errors[attribute] << options.fetch(:message) do
      I18n.t(translation_key, value: reference_value)
    end
  end

  private

  def compare_value(value, reference_value)
    value == reference_value
  end

  def translation_key
    'errors.messages.equality'
  end
end
