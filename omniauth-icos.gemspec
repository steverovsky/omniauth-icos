# -*- encoding: utf-8 -*-
$:.push File.expand_path('../lib', __FILE__)
require 'omniauth-icos/version'

Gem::Specification.new do |gem|
  gem.name        = 'omniauth-icos'
  gem.version     = OmniAuth::ICOS::VERSION
  gem.authors     = ['Nikita Anistratenko']
  gem.email       = ['steverovsky@gmail.com']
  gem.homepage    = 'https://github.com/steverovsky/omniauth-icos'
  gem.summary     = %q{OmniAuth strategy for ICOS ID}
  gem.description = %q{OmniAuth strategy for ICOS ID}

  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.require_paths = ['lib']

  gem.add_runtime_dependency 'omniauth', '~> 1.0'
  gem.add_runtime_dependency 'omniauth-oauth2', '~> 1.2'
  gem.add_dependency 'multi_json', '~> 1.3'

  gem.add_development_dependency 'rspec', '~> 2.7'
  gem.add_development_dependency 'rack-test', '~> 0.6'
  gem.add_development_dependency 'simplecov', '~> 0.10'
  gem.add_development_dependency 'webmock', '~> 1.20'
end
