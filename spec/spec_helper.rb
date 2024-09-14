# spec/spec_helper.rb

require 'rack/test'
require 'rspec'
require 'webmock/rspec'
require 'dotenv/load'   # Load environment variables
require_relative '../app'  # Load your Sinatra app

ENV['RACK_ENV'] = 'test'

RSpec.configure do |config|
  config.include Rack::Test::Methods

  # Define the Sinatra application to be tested
  def app
    Sinatra::Application  # Replace this with your specific app class if different
  end

  # Prevent real external connections except localhost
  WebMock.disable_net_connect!(allow_localhost: true)

  config.before(:suite) do
    # Ensure WebMock is enabled
    WebMock.enable!
  end

  config.after(:suite) do
    # Disable WebMock after tests
    WebMock.disable!
  end
end
