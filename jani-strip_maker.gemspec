# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'jani/strip_maker/version'

Gem::Specification.new do |spec|
  spec.name          = "jani-strip_maker"
  spec.version       = Jani::StripMaker::VERSION
  spec.authors       = ["Shin'ichi Ohno"]
  spec.email         = ["shin1ohno@me.com"]
  spec.summary       = "Make jani strip from movie file"
  spec.description   = "Make jani(https://github.com/shin1ohno/jani) strip from movie file."
  spec.homepage      = "https://github.com/shin1ohno/jani-strip_maker"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = "strip_maker"
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "rmagick", "2.13.3"
  spec.add_dependency "thor", "0.19.1"

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "rspec-collection_matchers"
end
