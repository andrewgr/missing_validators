# Allows to check if the value of a specific attribute is a valid MAC address.
#
# @example Validate that the device MAC address is valid.
#   class Device << ActiveRecord::Base
#     attr_accessor :lat
#     validates :lat, latitude: true
#   end
class LatitudeValidator < BaseValidator
  private

  def self.valid?(latitude, options)
    latitude.present? && latitude >= -90 && latitude <= 90
  end
end
