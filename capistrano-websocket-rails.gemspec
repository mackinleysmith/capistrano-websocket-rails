# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'capistrano/websocket-rails/version'

Gem::Specification.new do |spec|
  spec.name          = 'capistrano-websocket-rails'
  spec.version       = Capistrano::WebsocketRails::VERSION
  spec.authors       = ["MacKinley Smith"]
  spec.email         = ["smit1625@msu.edu"]

  spec.summary       = %q{WebsocketRails integration for Capistrano}
  spec.description   = %q{WebsocketRails integration for Capistrano}
  spec.homepage      = "https://github.com/smit1625/capistrano-websocket-rails"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # spec.add_development_dependency "bundler", "~> 1.10"
  # spec.add_development_dependency "rake", "~> 10.0"
  spec.add_dependency 'capistrano', '>= 3.0.0'
  spec.add_dependency 'websocket-rails', '>= 0.7.0'
end
