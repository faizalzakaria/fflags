
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "FFlags/version"

Gem::Specification.new do |spec|
  spec.name          = "FFlags"
  spec.version       = FFlags::VERSION
  spec.authors       = ["Faizal Zakaria"]
  spec.email         = ["fai@code3.io"]

  spec.summary       = %q{Feature flags that can be override per instance}
  spec.description   = %q{Feature flags that can be override per instance}
  spec.homepage      = "https://faizalzakaria.github.com"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency 'redis', '~> 3.0.0'

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
