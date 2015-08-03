# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'pretender/rails/version'

Gem::Specification.new do |spec|
  spec.name          = "pretender-rails"
  spec.version       = Pretender::Rails::VERSION
  spec.authors       = ["Chase McCarthy"]
  spec.email         = ["chase@code0100fun.com"]
  spec.summary       = %q{Stub clientside ajax requests using pretender}
  spec.description   = %q{Injects pretender into all HTML requests when a route has been stubbed}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
end
