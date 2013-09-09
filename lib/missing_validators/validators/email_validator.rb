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
  # @param [Object] value attribute value
  def validate_each(record, attribute, value)
    allow_blank = options[:allow_blank] || false
    return if allow_blank && value.blank?

    domains = Array.wrap(options[:domain])
    email = value && value.downcase || ''
    in_valid_domain = domains.empty? ? true : domains.any? { |domain| email.end_with?(".#{domain.downcase}") }

    has_valid_format = !!(value =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i)

    unless in_valid_domain && has_valid_format
      record.errors[attribute] << (options[:message] || I18n.t('errors.messages.email'))
    end
  end
end
