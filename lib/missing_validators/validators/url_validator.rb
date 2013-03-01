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
  # @param [Object] attribute attribute value
  def validate_each(record, attribute, value)
    valid_format = !!(value =~ /^(https?:\/\/)?([\da-z\.-]{2,})\.([a-z\.]{2,6})([\/\w \.-]*)*\/?$/i)

    unless valid_format
      message = options[:message] || I18n.t('errors.messages.url')
      record.errors[attribute] << message
    end
  end
end
