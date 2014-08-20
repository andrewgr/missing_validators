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

  def self.validate_domain(uri, domains)
    host_downcased = uri.host.to_s.downcase
    domains.empty? || domains.any? { |domain| host_downcased.end_with?(".#{domain.downcase}") }
  end

  def self.validate_scheme(uri, schemes)
    scheme_downcased = uri.scheme.to_s.downcase
    schemes.empty? || schemes.any? { |scheme| scheme_downcased == scheme.to_s.downcase }
  end

  def self.validate_root(uri)
    ['/', ''].include?(uri.path) && uri.query.blank? && uri.fragment.blank?
  end

  private

  DEFAULT_SCHEMES = [:http, :https]

  def valid?(uri, options)
    uri.kind_of?(URI::Generic) \
      && self.class.validate_domain(uri, [*(options[:domain])]) \
      && self.class.validate_scheme(uri, [*(options[:scheme] || UrlValidator::DEFAULT_SCHEMES)]) \
      && (!!options[:root] ? self.class.validate_root(uri) : true)
  end
end
