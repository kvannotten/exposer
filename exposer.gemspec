# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'exposer/version'

Gem::Specification.new do |spec|
  spec.name          = "exposer"
  spec.version       = Exposer::VERSION
  spec.authors       = ["Kristof Vannotten"]
  spec.email         = ["kristof@vannotten.be"]
  spec.description   = %q{Exposer is an application that allows the user to show a locally run website over the internet to other users.}
  spec.summary       = %q{Exposer is an application that allows the user to show a locally run website over the internet to other users.}
  spec.homepage      = "https://github.com/kvannotten/exposer"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  
  spec.add_dependency "net-ssh"
  spec.add_dependency "json"
end
