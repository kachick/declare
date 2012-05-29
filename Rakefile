gem 'hoe', '~> 3.0.6'
require 'hoe'
require 'fileutils'

Hoe.plugin :newgem

$hoe = Hoe.spec 'declare' do
  developer 'Kenichi Kamiya', 'kachick1+ruby@gmail.com'
  self.rubyforge_name       = name
  require_ruby_version '>= 1.9.3'
  dependency 'yard', '~> 0.8.1', :development
end

require 'newgem/tasks'
Dir['tasks/**/*.rake'].each {|t|load t}
