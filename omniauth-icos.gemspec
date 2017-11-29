# -*- encoding: utf-8 -*-
$:.push File.expand_path('../lib', __FILE__)
require 'omniauth-icos/version'

Gem::Specification.new do |gem|
  gem.name        = 'omniauth-icos'
  gem.version     = OmniAuth::ICOS::VERSION
  gem.authors     = ['Nikita Anistratenko']
  gem.email       = ['steverovsky@gmail.com']
  gem.homepage    = 'https://github.com/arthurnn/omniauth-500px'
  gem.summary     = %q{OmniAuth strategy for ICOS ID}
  gem.description = %q{OmniAuth strategy for ICOS ID}

  # s.rubyforge_project = "omniauth-500px'

  # s.files         = `git ls-files`.split("\n")
  # s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  # s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.require_paths = ['lib']

  gem.add_runtime_dependency 'omniauth'
  gem.add_runtime_dependency 'omniauth-oauth2'
  gem.add_runtime_dependency 'multi_json'

  gem.add_development_dependency 'rspec', '~> 2.7'
  gem.add_development_dependency 'rack-test'
  gem.add_development_dependency 'simplecov'
  gem.add_development_dependency 'webmock'
end
