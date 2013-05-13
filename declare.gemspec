require File.expand_path('../lib/declare/version', __FILE__)

Gem::Specification.new do |gem|
  # specific

  gem.description   = %q{A unit testing framework.}
  gem.summary       = gem.description.dup
  gem.homepage      = 'http://kachick.github.com/declare/'
  gem.license       = 'MIT'
  gem.name          = 'declare'
  gem.version       = Declare::VERSION.dup

  gem.required_ruby_version = '>= 1.9.2'
  gem.add_development_dependency 'yard', '>= 0.8.6.1', '< 2'
  gem.add_development_dependency 'rake', '>= 10', '< 20'
  gem.add_development_dependency 'bundler', '>= 1.3.5', '< 2'

  # common

  gem.authors       = ['Kenichi Kamiya']
  gem.email         = ['kachick1+ruby@gmail.com']
  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features|declare)/})
  gem.require_paths = ['lib']

end