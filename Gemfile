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
gem 'resque-pool'

group :production do
  gem 'uglifier', '>= 1.3.0'
  gem 'rails_12factor'
end

group :doc do
  gem 'sdoc', require: false
end

group :test, :development do
  gem 'rspec-rails'
  gem 'shoulda-matchers'
  gem "factory_girl_rails", "~> 4.0"
end