# Allows to check if the value of a specific attribute is a valid MAC address.
#
# @example Validate that the device MAC address is valid.
#   class Device << ActiveRecord::Base
#     attr_accessor :mac
#     validates :mac, mac_address: true
#   end
class MacAddressValidator < BaseValidator
  def self.validate_format(mac_address)
    !!(mac_address =~ /^([\h]{2}:){5}[\h]{2}?$/i) ||            # 08:00:2b:01:02:03
      !!(mac_address =~ /^([\h]{2}[-|\.|\s]){5}[\h]{2}?$/i) ||  # 08-00-2b-01-02-03 or 08.00.2b.01.02.03
      !!(mac_address =~ /^([\h]{6})[-|\.][\h]{6}?$/i) ||        # 08002b-010203 or 08002b.010203
      !!(mac_address =~ /^([\h]{6}):[\h]{6}?$/i) ||             # 08002b:010203
      !!(mac_address =~ /^([\h]{4}[-|\.|\s]){2}[\h]{4}?$/i) ||  # 0800.2b01.0203 or 0800-2b01-0203 0800 2b01 0203
      !!(mac_address =~ /^[\h]{12}?$/i)                         # 08002b010203
  end

  private

  def self.valid?(mac_address, options)
    validate_format(mac_address)
  end
end
