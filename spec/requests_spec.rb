# spec/app_spec.rb
require 'spec_helper'
require 'json'

RSpec.describe 'Guardian Angel API' do
  include Rack::Test::Methods

  # Helper method to load fixture files
  def load_fixture(file_name)
    file_path = File.join(File.dirname(__FILE__), 'fixtures', file_name)
    JSON.parse(File.read(file_path))
  end

  before(:each) do
    # Stub the /countries API endpoint
    stub_request(:get, "https://api.throughlinecare.com/v1/countries")
      .to_return(status: 200, body: File.read('spec/fixtures/countries.json'), headers: {})

    # Stub the /topics API endpoint
    stub_request(:get, "https://api.throughlinecare.com/v1/topics")
      .to_return(status: 200, body: File.read('spec/fixtures/topics.json'), headers: {})

    # Stub the /helplines API endpoint
    stub_request(:get, "https://api.throughlinecare.com/v1/helplines")
      .with(query: hash_including({ "country_code" => "us", "limit" => "5" }))
      .to_return(status: 200, body: File.read('spec/fixtures/helplines.json'), headers: {})

    # Stub the /helplines/:id API endpoint
    stub_request(:get, "https://api.throughlinecare.com/v1/helplines/c8e47108-3f87-4311-ab8f-7a3adf01ba06")
      .to_return(status: 200, body: File.read('spec/fixtures/helpline_details.json'), headers: {})
  end

  # Test the /countries endpoint
  describe 'GET /countries' do
    it 'returns a list of countries' do
      get '/countries'

      expect(last_response.status).to eq(200)
      response_body = JSON.parse(last_response.body)

      # Compare the response with the loaded fixture
      expected_data = load_fixture('countries.json')['countries']
      expect(response_body['countries']).to eq(expected_data)
    end
  end

  # Test the /topics endpoint
  describe 'GET /topics' do
    it 'returns a list of topics' do
      get '/topics'

      expect(last_response.status).to eq(200)
      response_body = JSON.parse(last_response.body)

      # Compare the response with the loaded fixture
      expected_data = load_fixture('topics.json')['topics']
      expect(response_body['topics']).to eq(expected_data)
    end
  end

  # Test the /helplines endpoint
  describe 'GET /helplines' do
    it 'returns a list of helplines' do
      get '/helplines?country_code=us&limit=5'

      expect(last_response.status).to eq(200)
      response_body = JSON.parse(last_response.body)

      # Compare the response with the loaded fixture
      expected_data = load_fixture('helplines.json')['helplines']
      expect(response_body['helplines']).to eq(expected_data)
    end
  end

  # Test the /helplines/:id endpoint
  describe 'GET /helplines/:id' do
    it 'returns details of a specific helpline' do
      valid_helpline_id = 'c8e47108-3f87-4311-ab8f-7a3adf01ba06'
      get "/helplines/#{valid_helpline_id}"

      expect(last_response.status).to eq(200)
      response_body = JSON.parse(last_response.body)

      # Load expected data from the fixture
      expected_helpline = load_fixture('helpline_details.json')['helpline']
      expect(response_body['helpline']).to eq(expected_helpline)
    end
  end
end
