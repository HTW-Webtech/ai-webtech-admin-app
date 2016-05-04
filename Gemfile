source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.6'
# gem 'rails', '5.0.0.beta3'
# Use postgresql as the database for Active Record
gem 'pg'
# Use SCSS for stylesheets
# gem 'sass-rails', '~> 5.0'
gem 'sass-rails'
# Use Uglifier as compressor for JavaScript assets
# gem 'uglifier', '>= 1.3.0'
gem 'uglifier'
# Use CoffeeScript for .coffee assets and views
# gem 'coffee-rails', '~> 4.1.0'
gem 'coffee-rails'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# TODO: Will be useful starting with version 3 (when partial replacements are possible).
# This way I can e.g. render the navigation once without the need to re-render it with
# each request.
# gem 'turbolinks'
gem 'exception_notification'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

gem 'aris-control'
gem 'complex_config', require: 'complex_config/rude'

group :production do
  # TODO: Depends on actionpack >= 3
  gem 'lograge' # Collapses rails logs into oneline. Makes correlations for performance inspections much more feasible
end

gem 'skylight'

gem 'devise', '~> 3'
# TODO: Rails Admin does not work for Rails 5 but it since I am not using it at all thats fine
gem 'rails_admin'
gem 'cancancan', '~> 1.10'

gem 'switch_user'

# gem 'simple_form', '~> 3'
# gem 'simple_form', '3.2.1'
gem 'simple_form'
gem 'bootstrap-sass', '~> 3.3'
gem 'slim'

gem 'active_link_to' # TODO: Should work with rails 5?
gem 'autosize-rails'
gem 'dotenv-rails', require: 'dotenv/rails-now'

gem 'rack-mini-profiler'

group :development, :test do
  gem 'rspec'
  # gem 'rspec-rails', '~> 3.0'
  # gem 'rspec-rails', '3.5.0.beta1'
  gem 'rspec-rails'
  gem 'byebug'
  gem 'foreman'
end

group :test do
  gem 'factory_girl_rails'
  gem 'capybara'
  gem 'launchy'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end

