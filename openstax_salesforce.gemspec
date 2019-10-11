$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "openstax/salesforce/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "openstax_salesforce"
  s.version     = OpenStax::Salesforce::VERSION
  s.authors     = ["JP Slavinsky"]
  s.email       = ["jps@kindlinglabs.com"]
  s.homepage    = "https://github.com/openstax/openstax_salesforce"
  s.summary     = "Interface gem for accessing OpenStax's Salesforce instance"
  s.description = "Interface gem for accessing OpenStax's Salesforce instance"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir['spec/**/*']

  s.add_dependency "rails", "~> 5.0"
  s.add_dependency "restforce"
  s.add_dependency "active_force"
  s.add_dependency "omniauth-salesforce"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "factory_bot_rails"
  s.add_development_dependency "faker"
  s.add_development_dependency "byebug"
  s.add_development_dependency "database_cleaner"
  s.add_development_dependency "sprockets", "< 4.0"
end
