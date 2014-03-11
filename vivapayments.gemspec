require File.expand_path('../lib/vivapayments/version', __FILE__)

Gem::Specification.new do |gem|
  gem.name                  = 'vivapayments'
  gem.version               = Vivapayments::VERSION
  gem.authors               = ['Giannis Melidis']
  gem.email                 = ['gmelidis@engineer.com']
  gem.summary               = 'Wrapper for the Vivapayments API.'
  gem.description           = gem.summary
  gem.required_ruby_version = '>= 1.9.3'

  gem.files = `git ls-files`.split("\n").sort

  gem.add_dependency 'faraday'
  gem.add_development_dependency 'rspec'
  gem.add_development_dependency 'pry'
end
