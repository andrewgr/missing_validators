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
    domains = Array.wrap options[:domain]

    allow_blank = options[:allow_blank] || false

    value = "" if allow_blank && !value

    if !allow_blank && !value
      message = options[:message] || I18n.t('errors.messages.email')
      record.errors[attribute] << message
    end

    valid_domain = true

    valid_format = !!(value =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i)
    if domains.any?
      valid_domain = domains.inject (false) do |acc, domain|
        acc || value.end_with?(".#{domain}")
      end
    end

    unless valid_format && valid_domain
      message = options[:message] || I18n.t('errors.messages.email')
      record.errors[attribute] << message
    end
  end
end