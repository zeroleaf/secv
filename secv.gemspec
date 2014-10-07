# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'secv/version'

Gem::Specification.new do |spec|
  spec.name          = "secv"
  spec.version       = Secv::VERSION
  spec.authors       = ["zeroleaf"]
  spec.email         = ["zeroleaf021@gmail.com"]
  spec.summary       = %q{Translator Console Version}
  spec.description   = %q{More in future.}
  spec.homepage      = "https://github.com/zeroleaf/secv"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "nokogiri", "~> 1.6"
  spec.add_runtime_dependency "colored", "~> 1.2"
  spec.add_runtime_dependency "sqlite3", "~> 1.3"

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "byebug", "~> 3.5"
end
