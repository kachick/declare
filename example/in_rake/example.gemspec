# frozen_string_literal: true
Gem::Specification.new do |gem|
  gem.authors       = ['foo bar']
  gem.email         = ['foo@example.com']
  gem.description   = %q{:)}
  gem.summary       = %q{:)}
  gem.homepage      = 'https://github.com/your_name/your_awesome_gem'

  gem.files         = `git ls-files`.split($\)
  gem.name          = 'your_awesome_gem'
  gem.require_paths = ['lib']
  gem.version       = '0.0.1'

  gem.required_ruby_version = '>= 2.6.0'

  gem.add_development_dependency 'declare'
  gem.add_development_dependency 'rake'
end
