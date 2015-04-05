# Checks if the value of an attribute is a valid longitude value.
#
# @example Validate that the device latitude is valid.
#   class Device << ActiveRecord::Base
#     attr_accessor :latitude
#     validates :latitude, latitude: true
#   end
class LatitudeValidator < BaseValidator
  private

  def valid?(latitude, _)
    latitude.present? && latitude.between?(-90, 90)
  end
end
