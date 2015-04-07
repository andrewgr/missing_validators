require 'uri'
# Checks if the value of an attribute is a valid URL.
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
    uri = parse(value)
    fail Addressable::URI::InvalidURIError unless valid?(uri, options)
  rescue
    record.errors[attribute] << options.fetch(:message) do
      I18n.t('errors.messages.url')
    end
  end

  private

  def parse(url)
    Addressable::URI.parse(url).tap do |uri|
      fail Addressable::URI::InvalidURIError if uri.nil? || uri.host.nil?
    end
  end

  def validate_host(uri)
    !uri.host.include?(' ') && \
      uri.host.include?('.') && \
      uri.host.split('.').last.length > 1
  end

  def validate_top_level_domain(uri, *domains)
    return true if domains.empty?

    host = uri.host.to_s.downcase
    domains.any? { |domain| host.end_with?(".#{domain.downcase}") }
  end

  def validate_scheme(uri, *schemes)
    return true if schemes.empty?

    scheme_downcased = uri.scheme.to_s.downcase
    schemes.any? { |scheme| scheme_downcased == scheme.to_s.downcase }
  end

  def validate_root(uri)
    ['/', ''].include?(uri.path) && \
      uri.query.blank? && \
      uri.fragment.blank?
  end

  def valid?(uri, options)
    validate_host(uri) && \
      validate_top_level_domain(uri, *options[:domain]) && \
      validate_scheme(uri, *options[:scheme]) && \
      (options[:root] == true ? validate_root(uri) : true)
  end
end
