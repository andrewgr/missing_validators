# Allows to check if the value of a specific attribute is a valid email address.
#
# @example Validate that the user email is a valid email address.
#   class User << ActiveRecord::Base
#     attr_accessor :email, :name
#     validates :email, email: true
#   end
class EmailValidator < BaseValidator
  def self.validate_format(email)
    !!(email =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i)
  end

  def self.validate_domain(email, domains)
    email_downcased = email.to_s.downcase
    domains.empty? || domains.any? { |domain| email_downcased.end_with?(".#{domain.downcase}") }
  end

  private

  def self.valid?(email, options)
    validate_format(email) \
      && validate_domain(email, [*(options[:domain])])
  end
end
