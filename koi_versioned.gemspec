$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "koi_versioned/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "koi_versioned"
  s.version     = KoiVersioned::VERSION
  s.authors     = ["Rahul Trikha"]
  s.email       = ["rahul@katalyst.com.au"]
  s.homepage    = "https://github.com/rahult/koi_versioned"
  s.summary     = "Adds an ability to store draft for an ActiveRecord model"
  s.description = "Provides ability for an ActiveRecord model to store its attributes in a draft state."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_development_dependency 'rspec-rails', '~> 2.6'
  s.add_development_dependency 'capybara'
  s.add_development_dependency 'rails', '~> 3.2'
  s.add_development_dependency 'factory_girl_rails', '>= 1.2.0'
  s.add_development_dependency 'database_cleaner'
  s.add_development_dependency 'forgery'

  s.add_dependency "rails", "~> 3.2"
end
