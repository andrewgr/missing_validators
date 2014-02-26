# Allows to check if the value of a specific attribute is a valid MAC address.
#
# @example Validate that the device MAC address is valid.
#   class Device << ActiveRecord::Base
#     attr_accessor :lat
#     validates :lat, latitude: true
#   end
class LatitudeValidator < ActiveModel::EachValidator
  # Checks if an attribute value is a valid MAC address.
  #
  # @param [Object] record object to validate
  # @param [String] attribute name of the object attribute to validate
  # @param [Object] value attribute value
  def validate_each(record, attribute, value)
    allow_blank = options[:allow_blank] || false
    return if allow_blank && value.blank?

    unless self.class.valid?(value, options)
      record.errors[attribute] << (options[:message] || I18n.t('errors.messages.latitude'))
    end
  end

  private

  def self.valid?(latitude, options)
    latitude.present? && latitude >= -90 && latitude <= 90
  end

end
