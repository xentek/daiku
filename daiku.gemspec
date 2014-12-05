# encoding: utf-8

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'daiku/version'

Gem::Specification.new do |gem|
  gem.name          = "daiku"
  gem.version       = Daiku::VERSION
  gem.authors       = ['Eric Marden']
  gem.email         = ['eric@xentek.net']
  gem.summary       = %q{Craft lightweight ruby applications}
  gem.description   = %q{Daiku, japanese for carpenter, helps you craft lightweight ruby applications}
  gem.homepage      = "https://github.com/xentek/daiku"
  gem.license       = "MIT"

  gem.files         = `git ls-files -z`.split("\x0")
  gem.executables   = gem.files.grep(%r{^bin/}) { |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ['lib']

  gem.add_dependency 'thor', '~> 0.18.0'
  
  gem.add_development_dependency 'bundler', '~> 1.5'
  gem.add_development_dependency 'rake'
end
