require "capybara/rails"
require 'capybara/rspec'

# Setup capybara webkit as the driver for javascript-enabled tests.
# Capybara.javascript_driver = :webkit


Capybara.default_selector = :css

Capybara.configure do |config|
  config.match = :prefer_exact
  config.ignore_hidden_elements = false
end

Capybara.register_driver :selenium_firefox do |app|
  Capybara::Selenium::Driver.new(app, :browser => :firefox)
end

#Capybara.default_driver = :selenium_firefox
#Capybara.current_driver = :selenium_firefox
Capybara.javascript_driver = :selenium_firefox
Capybara.default_max_wait_time = 10

Capybara.server_port = 7055

# We have more than one controller inheriting from
# ActionController::Base, and, in our app, ApplicationController redefines
# the default_url_options method, so we need to redefine the method for
# the two classes.
[ApplicationController, ActionController::Base].each do |klass|
  klass.class_eval do
    def default_url_options(options = {})
      { :host => "127.0.0.1", :port => Capybara.server_port }.merge(options)
    end
  end
end