# coding: utf-8
gem_name = "mini_cli" # TODO: Rename this

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "#{gem_name}/version"

Gem::Specification.new do |spec|
  spec.name          = gem_name
  spec.version       = MiniCli::VERSION
  spec.authors       = ["Manuel Morales"]
  spec.email         = ['manuelmorales@gmail.com']
  spec.description   = "CLI for microservices"
  spec.summary       = "A Thor based CLI for services and Ruby apps."
  spec.homepage      = "https://github.com/manuelmorales/#{spec.name.gsub('_','-')}"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency 'thor', '~> 0.19'
  spec.add_runtime_dependency 'rerun', '~> 0.10'
  spec.add_runtime_dependency 'puma', '~> 2.10'

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake", '~> 10.4'
end
