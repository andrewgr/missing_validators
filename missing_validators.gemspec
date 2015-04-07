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
  gem.executables   = gem.files.grep(/^bin\//).map { |f| File.basename(f) }
  gem.test_files    = gem.files.grep(/^(spec)\//)
  gem.name          = 'missing_validators'
  gem.require_paths = ['lib']
  gem.version       = MissingValidators::VERSION

  gem.add_runtime_dependency 'activemodel', '~> 4'
  gem.add_runtime_dependency 'activesupport', '~> 4'
  gem.add_runtime_dependency 'addressable', '~> 2.3'

  gem.add_development_dependency 'rspec'
  gem.add_development_dependency 'rubocop'
  gem.add_development_dependency 'cane'
  gem.add_development_dependency 'shoulda'
  gem.add_development_dependency 'shoulda-matchers'
  gem.add_development_dependency 'codeclimate-test-reporter'
end
