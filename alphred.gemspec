# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'alphred/version'

Gem::Specification.new do |spec|
  spec.name          = 'alphred'
  spec.version       = Alphred::VERSION
  spec.authors       = ['Alpha Chen']
  spec.email         = ['alpha.chen@gmail.com']

  spec.summary       = %q{Helper utilities for making Alfred workflows.}
  spec.homepage      = 'https://github.com/kejadlen/alphred'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'bin'
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'builder', '~> 3.2'

  spec.add_development_dependency 'bundler', '>= 2.2.33'
  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'minitest'
end
