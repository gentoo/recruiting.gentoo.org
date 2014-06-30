source 'https://rubygems.org'

ruby '2.1.2'
gem 'rails', '>= 4.1.0'
gem 'rails-i18n'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

# Gems used only for assets and not required
# in production environments by default.
gem 'haml_coffee_assets', github: "netzpirat/haml_coffee_assets"
gem 'execjs'
gem 'compass-rails'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
gem 'therubyracer', :platforms => :ruby
gem 'bootstrap-sass'
gem 'font-awesome-sass'

gem 'bootswatch-rails'
gem 'uglifier'
gem 'simple_form'

gem 'jquery-rails'
gem 'haml-rails'
gem 'devise'
gem 'cancan'
gem 'activeadmin', github: 'gregbell/active_admin'
gem 'thin'
gem 'psych'
gem 'redcarpet'
gem 'pygments.rb'
gem 'acts_as_commentable'
gem 'workflow'
#gem 'mailboxer'
gem 'gravatar-ultimate'
gem 'nokogiri'
gem 'kaminari'
gem 'backbone-on-rails'
gem 'yaml_db'
gem "paranoia", "~> 2.0"
gem 'protected_attributes', '~>1.0.1'

group :development, :test do
gem 'spring'
  gem 'pry'
  gem 'rspec-rails'
  gem 'unicorn'
  gem 'lol_dba'
  gem 'pg'
  gem 'factory_girl_rails'
end
group :test do
  gem 'cucumber-rails', require: false
  # database_cleaner is not required, but highly recommended
  gem 'database_cleaner'
  gem 'capybara'
  gem 'cucumber-debug'
  gem 'simplecov-csv', require: false
  gem 'capybara-webkit'
end
group :production do
  gem 'mysql2'
end

gem 'rails4_upgrade'
