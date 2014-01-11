# -*- encoding: utf-8 -*-
require File.expand_path('../lib/xrate/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["GoCoin"]
  gem.email         = ["dev@gocoin.com"]
  gem.description   = %q{Ruby client for the GoCoin backend exchange rate service."}
  gem.summary       = %q{Ruby client for the GoCoin backend exchange rate service."}
  gem.homepage      = "https://github.com/GoCoin/xrate-gem"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "xrate"
  gem.require_paths = ["lib"]
  gem.version       = Xrate::VERSION

  gem.add_dependency "faraday", "~> 0.8.8"
  gem.add_dependency "faraday_middleware", "~> 0.9.0"
  gem.add_development_dependency "simplecov"
  gem.add_development_dependency "rspec", "~> 2.11.0"
  gem.add_development_dependency "rake"
end
