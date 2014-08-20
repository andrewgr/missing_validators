# Allows to check if the value of a specific attribute is a valid hex color.
#
# @example Validate that the product color is a valid hex color.
#   class Product << ActiveRecord::Base
#     attr_accessor :color
#     validates :color, color: true
#   end
class ColorValidator < BaseValidator
  def self.validate_format(color)
    !!(color =~ /^#(?:[0-9a-f]{3})(?:[0-9a-f]{3})?$/i)
  end

  private

  def self.valid?(color, options)
    validate_format(color)
  end
end
