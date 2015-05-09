require 'active_model'
require 'addressable/uri'
require 'missing_validators/version'
require 'missing_validators/validators/base_validator'
require 'missing_validators/validators/equality_validator'
require 'missing_validators/validators/inequality_validator'
require 'missing_validators/validators/email_validator'
require 'missing_validators/validators/url_validator'
require 'missing_validators/validators/mac_address_validator'
require 'missing_validators/validators/longitude_validator'
require 'missing_validators/validators/latitude_validator'
require 'missing_validators/validators/color_validator'
require 'missing_validators/validators/imei_validator'

if defined?(RSpec)
  require 'rspec/matchers'
  require 'missing_validators/matchers/ensure_valid_email_format_of'
  require 'missing_validators/matchers/ensure_valid_url_format_of'
  require 'missing_validators/matchers/ensure_valid_mac_address_format_of'
  require 'missing_validators/matchers/ensure_valid_imei_format_of'
end

I18n.load_path << File.expand_path('../locales/en.yml', __FILE__)
