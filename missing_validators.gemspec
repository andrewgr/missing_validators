require File.expand_path('../lib/missing_validators/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ['Andrei Gridnev']
  gem.email         = ['andrew.gridnev@gmail.com']
  gem.summary       = 'Adds some handy validators.'
  gem.description   = 'Validates email addresses, URLs, IMEI, MAC addresses,
    latitude, longitude, hex colors and (in-)equality of attributes.'
  gem.homepage      = 'https://github.com/andrewgr/missing_validators/'
  gem.license       = 'MIT'

  gem.files         = `git ls-files`.split($ORS)
  gem.executables   = gem.files.grep(%r{^bin/}).map { |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^spec/})
  gem.name          = 'missing_validators'
  gem.require_paths = ['lib']
  gem.version       = MissingValidators::VERSION

  gem.add_runtime_dependency 'activemodel'
  gem.add_runtime_dependency 'activesupport'
  gem.add_runtime_dependency 'addressable', '~> 2.3'

  gem.add_development_dependency 'rspec', '~> 3.2'
  gem.add_development_dependency 'rubocop', '~> 0.30'
  gem.add_development_dependency 'cane', '~> 2.6', '>= 2.6.1'
  gem.add_development_dependency 'shoulda-matchers', '~> 2.8', '>= 2.8.0'
  gem.add_development_dependency 'codeclimate-test-reporter', '~> 0.4'
end
