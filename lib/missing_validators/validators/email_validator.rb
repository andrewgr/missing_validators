# Allows to check if the value of a specific attribute is a valid email address.
#
# @example Validate that the user email is a valid email address.
#   class User << ActiveRecord::Base
#     attr_accessor :email, :name
#     validates :email, email: true
#   end
class EmailValidator < ActiveModel::EachValidator
  # Checks if an attribute value is a valid email address.
  #
  # @param [Object] record object to validate
  # @param [String] attribute name of the object attribute to validate
  # @param [Object] attribute attribute value
  def validate_each(record, attribute, value)
    unless value =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
      message = options[:message] || I18n.t('errors.messages.email')
      record.errors[attribute] << message
    end
  end
end