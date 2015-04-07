# Checks if the value of an attribute is a valid email address.
#
# @example Validate that the user email is a valid email address.
#   class User << ActiveRecord::Base
#     attr_accessor :email, :name
#     validates :email, email: true
#   end
class EmailValidator < BaseValidator
  private

  EMAIL_FORMAT = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i

  def valid?(email, options)
    validate_format(email) && \
      validate_domain(email, *options[:domain])
  end

  def validate_format(email)
    (email =~ EMAIL_FORMAT).present?
  end

  def validate_domain(email, *domains)
    return true if domains.blank?

    email_downcased = email.to_s.downcase

    domains.any? do |domain|
      domain = domain.to_s.downcase
      domain = "@#{domain}" unless domain.start_with?('.')

      email_downcased.end_with?(domain)
    end
  end
end
