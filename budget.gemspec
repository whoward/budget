$LOAD_PATH.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'budget/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'budget'
  s.version     = Budget::VERSION
  s.authors     = ['William Howard', 'Matt Clark']
  s.email       = ['whoward.tke@gmail.com', 'matt.clark.1@gmail.com']
  s.summary     = 'Rails engine for managing your budget'
  s.license     = 'MIT'

  s.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.rdoc']
  s.test_files = Dir['test/**/*']

  s.add_dependency 'rails', '~> 4.2.4'

  s.add_dependency 'pg'
  s.add_dependency 'haml'
  s.add_dependency 'twitter-bootstrap-rails'
  s.add_dependency 'bootstrap_form'
  s.add_dependency 'awesome_nested_set'
  s.add_dependency 'ransack'
  s.add_dependency 'bootstrap-kaminari-views'
end
