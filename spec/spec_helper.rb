# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'
require 'capybara/rails'
require 'capybara/rspec'
require 'capybara/poltergeist'
require 'translations'
require 'database_cleaner'

Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

ActiveRecord::Migration.check_pending! if defined?(ActiveRecord::Migration)
RSpec.configure do |config|

  config.before :suite do
    DatabaseCleaner.strategy = :truncation
  end

  config.before :each do
    DatabaseCleaner.start
  end

  config.after :each do
    DatabaseCleaner.clean
  end

  config.include I18nHelpers
  # config.fixture_path = "#{::Rails.root}/spec/fixtures"
  # config.use_transactional_fixtures = true

  config.infer_base_class_for_anonymous_controllers = false

  config.order = "random"
end

Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(app, :phantomjs => Phantomjs.path)
end

Capybara.javascript_driver = :poltergeist
Capybara.default_driver = :poltergeist



def login
  user = FactoryGirl.create(:user, password: "password")
  visit login_path(locale: :en)
  page.execute_script("$('#password').show()")
  within "#login-form" do
    fill_in "email", with: user.email
    fill_in "password", with: "password"
    click_on "Log in"
  end
  user
end
