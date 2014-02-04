source 'https://rubygems.org'

gem 'rails', '4.0.2'
gem "haml-rails"

gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder', '~> 1.2'
gem 'sass-rails', '~> 4.0.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'pg'
gem 'rails_admin'

gem 'koala'
gem 'resque-scheduler', :require => 'resque_scheduler'
gem 'resque', require: 'resque/server'


#Pagination with
#https://github.com/amatsuda/kaminari

group :production do
  gem 'uglifier', '>= 1.3.0'
end

group :doc do
  gem 'sdoc', require: false
end

group :test, :development do
  gem 'rspec-rails'
  gem 'sqlite3'
  gem 'capybara'
  gem 'shoulda-matchers'
end