# Checks if the value of an attribute is a valid IMEI number.
#
# @example Validate that a device IMEI number is valid.
#   class Device << ActiveRecord::Base
#     attr_accessor :imei
#     validates :imei, imei: true
#   end
class ImeiValidator < BaseValidator
  private

  # 356843052637512 or 35-6843052-637512 or 35.6843052.637512
  IMEI_FORMAT = /\A[\d\.\:\-\s]+\z/i

  def validate_format(imei_number)
    (imei_number =~ IMEI_FORMAT).present?
  end

  def validate_luhn_checksum(numbers)
    sum = 0
    i = 0

    numbers.each_char do |ch|
      n = ch.to_i
      n *= 2 if i.odd?
      n = 1 + (n - 10) if n >= 10

      sum += n
      i += 1
    end

    (sum % 10).zero?
  end

  def valid?(imei, _)
    validate_format(imei.to_s) && \
      validate_luhn_checksum(imei.to_s.gsub(/\D/, '').reverse)
  end
end
