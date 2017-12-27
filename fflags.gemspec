
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'fflags/version'

Gem::Specification.new do |spec|
  spec.name          = 'fflags'
  spec.version       = FFlags::VERSION
  spec.authors       = ['Faizal Zakaria']
  spec.email         = ['fai@code3.io']

  spec.summary       = 'Feature flags that can be override on the fly.'
  spec.description   = 'Feature flags that can be override on the fly.'
  spec.homepage      = 'https://github.com/faizalzakaria/fflags'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'redis', '>= 3.0.0'

  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rubocop'
end
