require 'codeclimate-test-reporter'
CodeClimate::TestReporter.start

require 'missing_validators'
require 'shoulda/matchers/active_record'
require 'shoulda-matchers'

I18n.enforce_available_locales = false
