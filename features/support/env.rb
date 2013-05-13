require 'simplecov'
require 'cucumber/debug'
require 'cucumber/rails'

Capybara.default_selector = :css
ActionController::Base.allow_rescue = false
DatabaseCleaner.strategy = :transaction
Cucumber::Rails::Database.javascript_strategy = :truncation
ENV["RAILS_ENV"] = "test"
require File.expand_path(File.dirname(__FILE__) + '/../../config/environment')
require 'cucumber/rails/world'
Cucumber::Rails::World.use_transactional_fixtures
