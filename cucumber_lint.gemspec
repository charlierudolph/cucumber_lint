# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cucumber_lint/version'

Gem::Specification.new do |spec|
  spec.name          = 'cucumber_lint'
  spec.version       = CucumberLint::VERSION
  spec.authors       = ['charlierudolph']
  spec.email         = ['charles.w.rudolph@gmail.com']
  spec.summary       = 'A command line interface for linting and formatting cucumber features'
  spec.homepage      = 'https://github.com/charlierudolph/cucumber_lint'
  spec.license       = 'MIT'

  spec.add_runtime_dependency 'colorize', '~> 0.7.5'

  spec.add_development_dependency 'cucumber', '~> 1.3.18'
  spec.add_development_dependency 'open4', '~> 1.3.4'
  spec.add_development_dependency 'rake', '~> 10.4.2'
  spec.add_development_dependency 'rspec', '~> 3.1.0'
  spec.add_development_dependency 'rubocop', '~> 0.28.0'

  spec.files         = `git ls-files`.split("\n")
  spec.executables   = spec.files.grep(/^bin\//) { |f| File.basename(f) }
  spec.require_paths = ['lib']
end
