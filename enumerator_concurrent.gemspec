# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'enumerator_concurrent/version'

Gem::Specification.new do |spec|
  spec.name          = 'enumerator_concurrent'
  spec.version       = EnumeratorConcurrent::VERSION
  spec.authors       = ['doodzik']
  spec.email         = ['frederik.dudzik@gmail.com']
  spec.summary       = 'Implements a concurrent each'
  spec.description   = 'for each iteration a new thread is started.'\
                       'Then the started threads are joind'
  spec.homepage      = 'https://github.com/doodzik/enumerator_concurrent.git'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\u0000")
  spec.executables   = spec.files.grep(/^bin\//) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(/^(test|spec|features)\//)
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.6'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'minitest', '~> 5.4.3' 
  spec.add_development_dependency 'rubocop', '~> 0.27'
end
