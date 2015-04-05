# Checks if the value of an attribute is a valid longitude.
#
# @example Validate that the device longitude is valid.
#   class Device << ActiveRecord::Base
#     attr_accessor :longitude
#     validates :longitude, longitude: true
#   end
class LongitudeValidator < BaseValidator
  private

  def valid?(longitude, _)
    longitude.present? && longitude.between?(-180, 180)
  end
end
