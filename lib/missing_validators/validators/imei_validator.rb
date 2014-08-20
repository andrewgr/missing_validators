# Allows to check if the value of a specific attribute is a valid IMEI address.
#
# @example Validate that the device IMEI address is valid.
#   class Device << ActiveRecord::Base
#     attr_accessor :imei
#     validates :imei, imei: true
#   end
class ImeiValidator < BaseValidator
  def self.validate_format(imei_number)
    !!(imei_number =~ /\A[\d\.\:\-\s]+\z/i) # 356843052637512 or 35-6843052-637512 or 35.6843052.637512
  end

  def self.luhn_valid?(input)
    numbers = input.gsub(/\D/, '').reverse

    sum, i = 0, 0

    numbers.each_char do |ch|
      n = ch.to_i
      n *= 2 if i.odd?
      n = 1 + (n - 10) if n >= 10

      sum += n
      i   += 1
    end

    (sum % 10).zero?
  end

  private

  def self.valid?(imei, options)
    validate_format(imei.to_s) \
      && luhn_valid?(imei.to_s)
  end
end
