require 'codeclimate-test-reporter'
CodeClimate::TestReporter.start

require 'missing_validators'
require 'shoulda/matchers'
require 'shoulda/matchers/integrations/rspec'

I18n.enforce_available_locales = false
I18n.load_path << File.expand_path('../../config/locales/en.yml', __FILE__)
