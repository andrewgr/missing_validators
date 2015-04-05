# Checks if the value of an attribute is a valid hex color.
#
# @example Validate that the product color is a valid hex color.
#   class Product << ActiveRecord::Base
#     attr_accessor :color
#     validates :color, color: true
#   end
class ColorValidator < BaseValidator
  private

  HEX_COLOR_FORMAT = /^#(?:[0-9a-f]{3})(?:[0-9a-f]{3})?$/i

  def valid?(color, _)
    (color =~ HEX_COLOR_FORMAT).present?
  end
end
