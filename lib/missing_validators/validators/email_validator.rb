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

    unless valid?(value, options)
      record.errors[attribute] << (options[:message] || I18n.t('errors.messages.email'))
    end
  end

  def self.validate_format(email)
    !!(email =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i)
  end

  def self.validate_domain(email, domains)
    email_downcased = email.to_s.downcase
    domains.empty? || domains.any? { |domain| email_downcased.end_with?(".#{domain.downcase}") }
  end

  private

  def valid?(email, options)
    self.class.validate_format(email) \
      && self.class.validate_domain(email, [*(options[:domain])])
  end

end
