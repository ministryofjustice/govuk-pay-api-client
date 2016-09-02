# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'govuk_pay_api_client/version'

Gem::Specification.new do |spec|
  spec.name = 'govuk-pay-api-client'
  spec.version = GovukPayApiClient::VERSION
  spec.authors = ['Todd Tyree']
  spec.email = ['tatyree@gmail.com']

  spec.summary = %q{An API client to handle Govuk Pay interactions}
  spec.homepage = 'https://github.com/ministryofjustice/govuk-pay-api-client/'
  spec.licenses = 'MIT'

  spec.files = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.12'
  spec.add_development_dependency 'capybara', '~> 2.7'
  spec.add_development_dependency 'fuubar', '~> 2.0'
  spec.add_development_dependency 'mutant-rspec', '~> 0.8'
  spec.add_development_dependency 'pry-byebug', '~> 3.4'
  spec.add_development_dependency 'rails', '~> 5.0'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec-rails', '~> 3.5'
  spec.add_development_dependency 'rubocop', '~> 0.41'
  spec.add_development_dependency 'sqlite3', '~> 1.3'

  spec.add_dependency 'excon', '~> 0.51'
end
