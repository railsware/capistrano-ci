# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'capistrano/ci/version'

Gem::Specification.new do |spec|
  spec.name          = "capistrano-ci"
  spec.version       = Capistrano::Ci::VERSION
  spec.authors       = ["paladiy"]
  spec.email         = ["olexanderpaladiy@gmail.com"]
  spec.description   = %q{Capistrano recipe for checking CI build status}
  spec.summary       = %q{Capistrano recipe for checking CI build status}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", "2.14.1"
  spec.add_development_dependency "simplecov", "~> 0.7.1"
  spec.add_development_dependency "vcr", "~> 2.6.0"
  spec.add_development_dependency "webmock", "~> 1.14.0"

  spec.add_runtime_dependency "capistrano", ">=2.5.5"
  spec.add_runtime_dependency "httparty"

end
