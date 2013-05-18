source 'https://rubygems.org'

gem 'rails', '~> 3.2.13'
gem 'rails-i18n'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'haml_coffee_assets'
  gem 'execjs'
  gem 'compass-rails'
  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  gem 'therubyracer', :platforms => :ruby
  gem 'bootstrap-sass'
  gem 'font-awesome-sass-rails'

  gem 'bootswatch-rails', github: "isaiah/bootswatch-rails"
  gem 'uglifier', '>= 1.0.3'
end
gem 'simple_form'

gem 'jquery-rails'
gem 'haml-rails'
gem 'devise'
gem 'cancan'
gem 'activeadmin', '~> 0.5.0'
gem 'thin'
gem 'psych'
gem 'redcarpet', '~> 2.1.1'
gem 'pygments.rb', '0.3.1'
gem 'acts_as_commentable', '~> 3.0.1'
gem 'workflow'
#gem 'mailboxer'
gem 'gravatar-ultimate'
gem 'nokogiri'
gem 'kaminari'
gem 'backbone-on-rails'
gem 'yaml_db'
group :development, :test do
  gem 'pry'
  gem 'rspec-rails'
  gem 'unicorn'
  gem 'lol_dba'
  gem 'pg'
  gem 'factory_girl_rails'
end
group :test do
  gem 'cucumber-rails', :require => false
  # database_cleaner is not required, but highly recommended
  gem 'database_cleaner'
  gem 'capybara'
  gem 'cucumber-debug'
  gem 'simplecov-csv', require: false
  gem 'capybara-webkit', git: 'https://github.com/thoughtbot/capybara-webkit.git'
end
group :production do
  gem 'mysql2'
end
