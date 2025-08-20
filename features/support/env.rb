# frozen_string_literal: true

require 'cucumber/rails'
require 'capybara/cucumber'
require 'selenium-webdriver'

# Handle remote database URL for test environment
if Rails.env.test?
  # Allow remote database URL for testing
  require 'database_cleaner/active_record'
  DatabaseCleaner.allow_remote_database_url = true

  # Or alternatively, unset DATABASE_URL to use database.yml config
  # ENV.delete('DATABASE_URL')
end

# Configure Capybara
Capybara.default_driver = :selenium_chrome_headless
Capybara.javascript_driver = :selenium_chrome_headless

# Configure DatabaseCleaner
DatabaseCleaner.strategy = :transaction
Cucumber::Rails::Database.javascript_strategy = :truncation

# Before each scenario
Before do
  DatabaseCleaner.start
end

# After each scenario
After do
  DatabaseCleaner.clean
end

# Configure Chrome options for testing
Capybara.register_driver :selenium_chrome_headless do |app|
  options = Selenium::WebDriver::Chrome::Options.new
  options.add_argument('--headless')
  options.add_argument('--no-sandbox')
  options.add_argument('--disable-dev-shm-usage')
  options.add_argument('--window-size=1024,768')

  Capybara::Selenium::Driver.new(app, browser: :chrome, options: options)
end
