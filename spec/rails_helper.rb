require 'spec_helper'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'capybara/rspec'
require 'simple_bdd'
require 'shoulda/matchers'

config.include SimpleBdd, type: :feature
    # config.include Devise::TestHelpers, :type => :controller
    config.before(:suite) do
        DatabaseCleaner.strategy = :truncation
        DatabaseCleaner.clean_with(:truncation)
    end

    Shoulda::Matchers.configure do |config|
        config.integrate do |with|
        with.test_framework :rspec
        with.library :rails
    end
end

config.use_transactional_fixtures = false

config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
end

config.before(:each) do
    DatabaseCleaner.strategy = :transaction
end

config.before(:each, :js => true) do
    DatabaseCleaner.strategy = :truncation
end

config.before(:each) do
    DatabaseCleaner.start
end

config.after(:each) do
    DatabaseCleaner.clean
end
