# spec/app_spec.rb
require 'spec_helper'
require 'json'
require_relative '../serializers/helplines_serializer'

RSpec.describe 'Guardian Angel API' do
  include Rack::Test::Methods

  before(:each) do
    # Stub the OAuth token request
    stub_request(:post, "https://api.findahelpline.com/oauth/token")
    .with(
      body: {
        "client_id" => ENV['CLIENT_ID'],
        "client_secret" => ENV['CLIENT_SECRET'],
        "grant_type" => "client_credentials"
      },
      headers: {
        'Accept' => '*/*',
        'Content-Type' => 'application/x-www-form-urlencoded',
        'User-Agent' => 'Faraday v2.11.0'
      }
    ).to_return(status: 200, body: '{"access_token":"fake_access_token"}', headers: {})

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
    it 'returns a list of countries with correct fields' do
      get '/countries'

      expect(last_response.status).to eq(200)
      
      response_body = JSON.parse(last_response.body)
      
      # Parse the stringified 'countries' field
      countries = JSON.parse(response_body)['countries']

      expect(countries).to be_an(Array)

      first_country = countries.first
      expect(first_country['name']).to eq('New Zealand')
      expect(first_country['code']).to eq('NZ')
    end
  end

  # Test the /topics endpoint
  describe 'GET /topics' do
    it 'returns a list of topics with correct fields' do
      get '/topics'

      expect(last_response.status).to eq(200)
      
      response_body = JSON.parse(last_response.body)
      
      # Parse the stringified 'topics' field
      topics = JSON.parse(response_body)['topics']

      expect(topics).to be_an(Array)

      first_topic = topics.first
      expect(first_topic['name']).to eq('Abuse & domestic violence')
      expect(first_topic['code']).to eq('abuse-domestic-violence')
    end
  end

  # Test the /helplines endpoint
  describe 'GET /helplines' do
    it 'returns a list of helplines with correct fields' do
      get '/helplines?country_code=us&limit=5'

      expect(last_response.status).to eq(200)

      response_body = JSON.parse(last_response.body)
      
      # Parse the stringified 'helplines' field
      helplines = JSON.parse(response_body)['helplines']
      serialized_helplines = HelplinesSerializer.format_helplines(helplines)[:data]
      expect(serialized_helplines).to be_an(Array)
      
      first_helpline = serialized_helplines.first
      expect(first_helpline).to have_key(:id)
      expect(first_helpline[:id]).to eq("c8e47108-3f87-4311-ab8f-7a3adf01ba06")

      expect(first_helpline[:attributes]).to have_key(:name)
      expect(first_helpline[:attributes][:name]).to eq("988 Suicide & Crisis Lifeline")

      expect(first_helpline[:attributes]).to have_key(:description)
      expect(first_helpline[:attributes][:description]).to include("988 Suicide & Crisis Lifeline is a suicide prevention and crisis intervention service available to anyone in suicidal crisis or emotional distress")
    end
  end

  # Test the /helplines/:id endpoint
  describe 'GET /helplines/:id' do
    it 'returns details of a specific helpline with correct fields' do
      valid_helpline_id = 'c8e47108-3f87-4311-ab8f-7a3adf01ba06'
      get "/helplines/#{valid_helpline_id}"

      expect(last_response.status).to eq(200)
      response_body = JSON.parse(last_response.body)

      # Parse the stringified 'helpline' field
      helpline = JSON.parse(response_body)['helpline']
      serialized_helpline = HelplinesSerializer.format_helpline(helpline)[:data]

      expect(serialized_helpline).to be_an(Array)

      expect(serialized_helpline.first).to have_key(:id)
      expect(serialized_helpline.first[:id]).to eq("c8e47108-3f87-4311-ab8f-7a3adf01ba06")

      expect(serialized_helpline.first[:attributes]).to have_key(:name)
      expect(serialized_helpline.first[:attributes][:name]).to eq("988 Suicide & Crisis Lifeline")

      expect(serialized_helpline.first[:attributes]).to have_key(:description)
      expect(serialized_helpline.first[:attributes][:description]).to include("988 Suicide & Crisis Lifeline is a suicide prevention and crisis intervention service available to anyone in suicidal crisis or emotional distress")
    end
  end
end
