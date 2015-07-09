source 'https://rubygems.org'
gem 'rails', '4.2.3'
gem 'pg'
gem 'sass-rails', '~> 4.0.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'jquery-rails'
gem 'jbuilder', '~> 1.2'
gem 'travis'
gem 'high_voltage'
gem "ckeditor"
gem 'ckeditor_rails', '~> 4.0.2'
gem 'paperclip'
gem 'bcrypt-ruby'
gem 'yaml_db', github: 'jetthoughts/yaml_db', ref: 'fb4b6bd7e12de3cffa93e0a298a1e5253d7e92ba'
gem 'globalize'
gem 'kaminari'
gem 'meeting_finder', '0.1.5'
gem 'puma'
gem 'rails-i18n', '~> 4.0.0'
gem 'draper'
gem 'validates_timeliness'
gem 'responders'

group :development, :production do
  gem 'dalli'
end

group :development, :test do
  gem 'newrelic_rpm'
  gem 'quiet_assets'
  gem 'guard'
  gem 'guard-rspec'
end

group :test do
  gem 'rspec-rails'
  gem 'shoulda'
  gem 'factory_girl_rails'
  gem 'capybara'
  gem 'database_cleaner'
  gem 'selenium-webdriver'
  gem 'poltergeist'
  gem 'phantomjs', :require => 'phantomjs/poltergeist'
  gem 'json_spec'
end

group :development do
  gem 'binding_of_caller'
  gem 'better_errors'
  gem 'guard-livereload', require: false
  gem "rack-livereload"
end

group :production do
  gem 'rails_12factor'
end
