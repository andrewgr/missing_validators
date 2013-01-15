require 'missing_validators'

ENV["RAILS_ENV"] ||= 'test'

require "rails/test_help"
#require 'rspec/rails'
#require 'rspec/autorun'

# Load support files
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }
Dir["#{File.dirname(__FILE__)}/fabricators/**/*.rb"].each { |f| require f }
I18n.load_path << File.expand_path("../../config/locales/en.yml", __FILE__)

RSpec.configure do |config|
  config.mock_with :rspec

  config.before :suite do
  end

  config.before :each do
  end

  config.after :each do
  end
end
