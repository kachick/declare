Gem::Specification.new do |gem|
  gem.authors       = ['foo bar']
  gem.email         = ['foo@example.com']
  gem.description   = %q{:)}
  gem.summary       = %q{:)}
  gem.homepage      = 'https://github.com/kachick/declare'

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = 'example'
  gem.require_paths = ['lib']
  gem.version       = '0.0.1'

  gem.required_ruby_version = '>= 1.9.2'

  gem.add_development_dependency 'declare'
  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'bundler'
end

