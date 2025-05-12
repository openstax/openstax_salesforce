$:.push File.expand_path('lib', __dir__)

# Maintain your gem's version:
require 'openstax/salesforce/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'openstax_salesforce'
  s.version     = OpenStax::Salesforce::VERSION
  s.authors     = ['JP Slavinsky', 'Dante Soares', 'Michael Volo']
  s.email       = ['volo@rice.edu']
  s.homepage    = 'https://github.com/openstax/openstax_salesforce'
  s.summary     = "Interface gem for accessing OpenStax's Salesforce instance"
  s.description = "Interface gem for accessing OpenStax's Salesforce instance"
  s.license     = 'MIT'

  s.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.md']

  s.add_dependency 'rails', '>= 5.0', '< 7.0'
  s.add_dependency 'restforce'
  s.add_dependency 'openstax_active_force'

  s.add_development_dependency 'sqlite3', '< 2'
  s.add_development_dependency 'concurrent-ruby', '1.3.4'
  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'sprockets'
  s.add_development_dependency 'factory_bot_rails'
  s.add_development_dependency 'faker'
end
