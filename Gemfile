source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.3'

gem 'rails', '~> 5.2.3'
# gem 'sqlite3'

gem 'omniauth'
gem 'omniauth-google-oauth2'
gem 'json'
gem 'figaro'

gem 'google-api-client', :require => 'google/apis/gmail_v1'

gem 'therubyracer'

gem 'listen', '>= 3.0.5', '< 3.2'
gem 'byebug'
gem 'pry'
gem 'pry-rails'

gem 'turbolinks'

group :development do
  gem 'sqlite3'    #gem to use in development environment
end

group :production do
  gem 'pg'         #gem to use in production environment
end

