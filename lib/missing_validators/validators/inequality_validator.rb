# Checks if the value of an attribute is equal to a value or proc result.
#
class InequalityValidator < EqualityValidator
  private

  def compare_value(value, reference_value)
    value != reference_value
  end

  def translation_key
    'errors.messages.inequality'
  end
end
