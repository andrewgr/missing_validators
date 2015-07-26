# Checks if the value of an attribute is a valid IP address.
#
# @example Validate that the device IP address is valid.
#   class Host << ActiveRecord::Base
#     attr_accessor :ip
#     validates :ip, ip_address: true
#   end
class IpAddressValidator < BaseValidator
  private

  IP_ADDRESS_FORMATS = [
    /^([0-9]{1,3}\.){3}[0-9]{1,3}/   # 192.168.0.10
  ]

  def valid?(ip_address, _)
    IP_ADDRESS_FORMATS.any? { |format| (ip_address =~ format).present? }
  end
end
