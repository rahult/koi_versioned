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

group :test do
  gem 'rspec-rails'             , '2.3.1'
  gem 'shoulda'                 , '2.11.3'
  # Pretty printed test output
  gem 'turn'                    , '0.8.2', :require => false
end

group :development do
  # Deployment
  gem 'engineyard'
  # Debugging and Analysis
  gem 'ruby-debug19'            , '0.11.6'
  # Logs for Views
  gem 'rails-footnotes'         , '3.7.4'
  # Console Replacement
  gem 'pry'                     , '~> 0.9.7'
  # Powder makes POW easy
  gem 'powder'                  , '0.1.7'
end

