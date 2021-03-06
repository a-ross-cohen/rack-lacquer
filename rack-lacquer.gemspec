# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "rack-lacquer"
  spec.version       = '0.0.3'
  spec.authors       = ["Adam Ross Cohen"]
  spec.email         = ["a.ross.cohen@gmail.com"]
  spec.description   = %q{Ruby driven ESI for non-production environments}
  spec.summary       = %q{Rack::Lacquer is intended to be used as a development drop-in replacement for varnish}
  spec.homepage      = "https://github.com/a-ross-cohen/rack-lacquer"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]
  
  spec.add_dependency 'nokogiri'

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
