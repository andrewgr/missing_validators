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
    raise URI::InvalidURIError unless uri.kind_of?(URI::HTTP)

    domains = Array.wrap(options[:domain])
    host = uri.host.downcase
    in_valid_domain = domains.empty? || domains.any? { |domain| host.end_with?(".#{domain.downcase}") }
    raise URI::InvalidURIError unless in_valid_domain

    must_be_domain_root = options[:root] || false
    if must_be_domain_root && (!uri.path.in?('/', '') || uri.query.present? || uri.fragment.present?)
      raise URI::InvalidURIError
    end
  rescue URI::InvalidURIError
    record.errors[attribute] << (options[:message] || I18n.t('errors.messages.url'))
  end
end
