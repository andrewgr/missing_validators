# Allows to check if the value of a specific attribute is a valid MAC address.
#
# @example Validate that the device MAC address is valid.
#   class Device << ActiveRecord::Base
#     attr_accessor :lon
#     validates :lon, longitude: true
#   end
class LongitudeValidator < BaseValidator
  private

  def self.valid?(longitude, options)
    longitude.present? && longitude >= -180 && longitude <= 180
  end
end
