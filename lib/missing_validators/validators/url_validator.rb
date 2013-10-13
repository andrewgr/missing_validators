require 'uri'
# Allows to check if the value of a specific attribute is a valid URL.
#
# @example Validate that the user's blog URL is valid.
#   class User << ActiveRecord::Base
#     attr_accessor :blog, :name
#     validates :blog, url: true
#   end
class UrlValidator < ActiveModel::EachValidator
  # Checks if an attribute value is a valid URL.
  #
  # @param [Object] record object to validate
  # @param [String] attribute name of the object attribute to validate
  # @param [Object] value attribute value
  def validate_each(record, attribute, value)
    uri = URI.parse(value)
    raise URI::InvalidURIError unless valid?(uri, options)
  rescue URI::InvalidURIError
    record.errors[attribute] << (options[:message] || I18n.t('errors.messages.url'))
  end

  private

  DEFAULT_SCHEMES = [:http, :https]

  def valid?(uri, options)
    uri.kind_of?(URI::Generic) \
      && validate_domain(uri, Array.wrap(options[:domain])) \
      && validate_scheme(uri, Array.wrap(options[:scheme] || UrlValidator::DEFAULT_SCHEMES)) \
      && validate_root(uri, !!options[:root])
  end

  def validate_domain(uri, domains)
    host_downcased = uri.host.to_s.downcase
    domains.empty? || domains.any? { |domain| host_downcased.end_with?(".#{domain.downcase}") }
  end

  def validate_scheme(uri, schemes)
    scheme_downcased = uri.scheme.to_s.downcase
    schemes.empty? || schemes.any? { |scheme| scheme_downcased == scheme.to_s.downcase }
  end

  def validate_root(uri, should_validate)
    return true unless should_validate
    ['/', ''].include?(uri.path) && uri.query.blank? && uri.fragment.blank?
  end
end
