require 'missing_validators'
require 'shoulda-matchers'

I18n.load_path << File.expand_path("../../config/locales/en.yml", __FILE__)

RSpec.configure do |config|
  config.mock_with :rspec
end
