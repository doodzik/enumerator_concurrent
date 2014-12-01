# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'Enumerator/Concurrent/version'

Gem::Specification.new do |spec|
  spec.name          = "Enumerator-Concurrent"
  spec.version       = EnumeratorConcurrent::VERSION
  spec.authors       = ["doodzik"]
  spec.email         = ["frederik.dudzik@gmail.com"]
  spec.summary       = %q{Implements a concurrent each}
  spec.description   = %q{for each iteration a new thread is started. Then the started threads are joind}
  spec.homepage      = "https://github.com/doodzik/Enumerator-Concurrent.git"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency 'bundler', '1.6'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'minitest'
  spec.add_development_dependency 'rubocop'
end
