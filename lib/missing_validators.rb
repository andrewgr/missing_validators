require 'active_model'
require 'rspec/matchers' if defined?(RSpec)
require 'missing_validators/version'
require 'missing_validators/validators/base_validator'
require 'missing_validators/validators/inequality_validator'
require 'missing_validators/matchers/ensure_inequality_of_matcher' if defined?(RSpec)
require 'missing_validators/validators/equality_validator'
require 'missing_validators/matchers/ensure_equality_of_matcher' if defined?(RSpec)
require 'missing_validators/validators/is_equal_validator'
require 'missing_validators/matchers/ensure_is_equal_matcher' if defined?(RSpec)
require 'missing_validators/validators/is_not_equal_validator'
require 'missing_validators/matchers/ensure_is_not_equal_matcher' if defined?(RSpec)
require 'missing_validators/validators/email_validator'
require 'missing_validators/matchers/ensure_valid_email_format_of' if defined?(RSpec)
require 'missing_validators/validators/url_validator'
require 'missing_validators/matchers/ensure_valid_url_format_of' if defined?(RSpec)
require 'missing_validators/validators/mac_address_validator'
require 'missing_validators/matchers/ensure_valid_mac_address_format_of' if defined?(RSpec)
require 'missing_validators/validators/longitude_validator'
require 'missing_validators/validators/latitude_validator'
require 'missing_validators/validators/color_validator'
require 'missing_validators/validators/imei_validator'
require 'missing_validators/matchers/ensure_valid_imei_format_of' if defined?(RSpec)

# if you put your locales in <GEM_ROOT>/config/locales, they will be picked up automatically...
# But only if the gem is a Rails Engine, and this is not that.
I18n.load_path << File.expand_path('../../config/locales/en.yml', __FILE__)
