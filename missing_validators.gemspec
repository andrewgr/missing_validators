# -*- encoding: utf-8 -*-
require File.expand_path('../lib/missing_validators/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Andrew Gridnev"]
  gem.email         = ["andrew.gridnev@gmail.com"]
  gem.description   = %q{Adds some handy validators.}
  gem.summary       = %q{TODO: Write a gem summary}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "missing_validators"
  gem.require_paths = ["lib"]
  gem.version       = MissingValidators::VERSION

  gem.add_development_dependency 'sqlite3' # For the dummy application
  gem.add_development_dependency 'rspec-rails'
  gem.add_development_dependency 'fabrication'
  gem.add_development_dependency 'mongoid-rspec'

  gem.add_dependency 'rails', '~> 3.2.11'
  gem.add_dependency 'shoulda-matchers', '~> 1.4.0'
end
