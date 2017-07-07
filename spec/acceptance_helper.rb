require 'rails_helper'

RSpec.configure do |config|

  # Capybara.register_driver :chrome do |app|
  #   Capybara::Selenium::Driver.new(app, :browser => :chrome)
  # end
  Capybara.javascript_driver = :webkit

  # Подключючение макроса sign_in_user
  config.extend ControllerMacros, type: :controller

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = false

  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:each, js: true) do
    DatabaseCleaner.strategy = :truncation
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end

end