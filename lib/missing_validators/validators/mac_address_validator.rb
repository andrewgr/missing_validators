# Checks if the value of an attribute is a valid MAC address.
#
# @example Validate that the device MAC address is valid.
#   class Device << ActiveRecord::Base
#     attr_accessor :mac
#     validates :mac, mac_address: true
#   end
class MacAddressValidator < BaseValidator
  private

  MAC_ADDRESS_FORMATS = [
    /^(\h{2}:){5}\h{2}$/,         # 08:00:2b:01:02:03
    /^(\h{2}[-|\.|\s]){5}\h{2}$/, # 08-00-2b-01-02-03 08.00.2b.01.02.03
    /^(\h{6})[-|\.]\h{6}$/,       # 08002b-010203 08002b.010203
    /^(\h{6}):\h{6}$/,            # 08002b:010203
    /^(\h{4}[-|\.|\s]){2}\h{4}$/, # 0800.2b01.0203 0800 2b01 0203 0800-2b01-0203
    /^\h{12}$/                    # 08002b010203
  ]

  def valid?(mac_address, _)
    MAC_ADDRESS_FORMATS.any? { |format| (mac_address =~ format).present? }
  end
end
