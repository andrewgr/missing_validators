# -*- encoding: utf-8 -*-
require File.expand_path('../lib/missing_validators/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Andrew Gridnev"]
  gem.email         = ["andrew.gridnev@gmail.com"]
  gem.summary       = %q{Adds some handy validators.}
  gem.description   = %q{Validates email addresses, URLs, IMEI, MAC addresses and inequality of attributes.}
  gem.homepage      = "https://github.com/andrewgr/missing_validators/"
  gem.license       = 'MIT'

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map { |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "missing_validators"
  gem.require_paths = ["lib"]
  gem.version       = MissingValidators::VERSION

  gem.add_runtime_dependency 'activemodel', '~> 3.0', '> 3.0.0'
  gem.add_runtime_dependency 'activesupport', '~> 3.0', '> 3.0.0'

  gem.add_development_dependency 'rspec', '~> 0'
  gem.add_development_dependency 'shoulda-matchers', '~> 0'
end
