source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.1.0'

gem 'rails', '~> 6.1.4'

gem 'omniauth'
gem 'omniauth-google-oauth2'
gem 'json'
gem 'figaro'

gem 'google-api-client', :require => 'google/apis/gmail_v1'

# gem 'therubyracer'
gem 'mini_racer'

gem 'listen', '>= 3.0.5', '< 3.2'
gem 'byebug'
gem 'pry'
gem 'pry-rails'

gem 'turbolinks'

gem 'sass-rails'

gem 'bootstrap', '~> 4.3.1'
gem 'jquery-rails'

gem 'net-smtp', require: false

group :development do
  gem 'sqlite3'    #gem to use in development environment
end

group :production do
  gem 'pg'         #gem to use in production environment
end
