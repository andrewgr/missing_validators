# Allows to check if the value of a specific attribute is a valid hex color.
#
# @example Validate that the product color is a valid hex color.
#   class Product << ActiveRecord::Base
#     attr_accessor :color
#     validates :color, color: true
#   end
class ColorValidator < ActiveModel::EachValidator
  # Checks if an attribute value is a valid hex color.
  #
  # @param [Object] record object to validate
  # @param [String] attribute name of the object attribute to validate
  # @param [Object] value attribute value
  def validate_each(record, attribute, value)
    allow_blank = options[:allow_blank] || false
    return if allow_blank && value.blank?

    unless valid?(value, options)
      record.errors[attribute] << (options[:message] || I18n.t('errors.messages.color'))
    end
  end

  def self.validate_format(color)
    !!(color =~ /^#(?:[0-9a-f]{3})(?:[0-9a-f]{3})?$/i)
  end

  private

  def valid?(color, options)
    self.class.validate_format(color)
  end

end
