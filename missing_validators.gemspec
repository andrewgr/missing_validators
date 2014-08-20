# -*- encoding: utf-8 -*-
require File.expand_path('../lib/missing_validators/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Andrei Gridnev"]
  gem.email         = ["andrew.gridnev@gmail.com"]
  gem.summary       = %q{Adds some handy validators.}
  gem.description   = %q{Validates email addresses, URLs, IMEI, MAC addresses, latitude, longitude, hex colors and inequality of attributes.}
  gem.homepage      = "https://github.com/andrewgr/missing_validators/"
  gem.license       = 'MIT'

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map { |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "missing_validators"
  gem.require_paths = ["lib"]
  gem.version       = MissingValidators::VERSION

  gem.add_runtime_dependency 'activemodel'
  gem.add_runtime_dependency 'activesupport'

  gem.add_development_dependency 'rspec'
  gem.add_development_dependency 'shoulda-matchers'
  gem.add_development_dependency 'codeclimate-test-reporter'
end
