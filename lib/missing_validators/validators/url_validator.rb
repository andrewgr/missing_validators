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
    begin
      uri = URI.parse value
      valid_format = uri.kind_of? URI::HTTP
    rescue
      valid_format = false
    end

    unless valid_format
      message = options[:message] || I18n.t('errors.messages.url')
      record.errors[attribute] << message
    end
  end
end
