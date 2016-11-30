# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sprawl/version'

Gem::Specification.new do |spec|
  spec.name          = 'sprawl'
  spec.version       = Sprawl::VERSION
  spec.authors       = ['Chris Rohr', 'Mike Bevels']
  spec.email         = ['crohr@fortitudetec.com', 'mbevels@fortitudetec.com']

  spec.summary       = 'Microservice Relationship Visualization Tool'
  spec.description   = 'Utility to generate a visualization of the relationships in a microservice based system'
  spec.homepage      = 'https://github.com/fortitudetec/sprawl'
  spec.license       = 'MIT'

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'ruby-graphviz'

  spec.add_development_dependency 'bundler', '~> 1.13'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rubocop', '~> 0.45'
end
