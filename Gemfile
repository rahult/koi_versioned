source "http://rubygems.org"

# Declare your gem's dependencies in koi_versioned.gemspec.
# Bundler will treat runtime dependencies like base dependencies, and
# development dependencies will be added by default to the :development group.
gemspec

# jquery-rails is used by the dummy application
gem "jquery-rails"

# Declare any dependencies that are still in development here instead of in
# your gemspec. These might include edge Rails or gems from your path or
# Git. Remember to move these dependencies to your gemspec before releasing
# your gem to rubygems.org.

group :development, :test do
  # Database
  gem 'sqlite3'
  # Debugging and Analysis
  gem 'ruby-debug19'
  # Testing framework
  gem 'rspec-rails', '2.8.1'
  # Console Replacement
  gem 'pry'
  # Fixture Replacement
  gem 'factory_girl_rails'
  # Fake Data
  gem 'forgery'
end

group :development do
  # Powder makes POW easy
  gem 'powder'
end
