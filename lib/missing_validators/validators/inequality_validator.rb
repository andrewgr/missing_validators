# Allows to check if the value of a specific attribute is not equal to
# the value of another attribute of an object.
#
# @example Validate that flight origin is not the same as its destination.
#   class Flight << ActiveRecord::Base
#     attr_accessor :origin, :destination
#     validates :origin, inequality: { to: :destination }
#   end
class InequalityValidator < ActiveModel::EachValidator
  # Checks if an attribute value is unequal to another attrubute value.
  #
  # @param [Object] record object to validate
  # @param [String] attribute name of the object attribute to validate
  # @param [Object] value attribute value
  def validate_each(record, attribute, value)
    unequal_to_attr = options[:to]

    if unequal_to_attr.present? && value == record.send(unequal_to_attr.to_sym)
      message = options[:message] || I18n.t('errors.messages.inequality', attr: unequal_to_attr)
      record.errors[attribute] << message
    end
  end
end
