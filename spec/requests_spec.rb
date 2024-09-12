require 'spec_helper'
require 'json'

RSpec.describe 'Guardian Angel API' do
  # Test the /current_token endpoint
  describe 'GET /current_token' do
    it 'returns the current access token and expiration time' do
      get '/current_token'

      expect(last_response).to be_ok
      response_body = JSON.parse(last_response.body)

      # Check that the access token and expiration time are present
      expect(response_body).to have_key('access_token')
      expect(response_body).to have_key('expires_at')
      expect(response_body).to have_key('expires_in_seconds')
    end
  end

  # Test the /countries endpoint
  describe 'GET /countries' do
    it 'returns a list of countries' do
      get '/countries'

      expect(last_response.status).to eq(200)
      response_body = JSON.parse(last_response.body)

      # Assuming the countries list is an array
      expect(response_body).to be_an(Array)
      expect(response_body.first).to have_key('name')  # Example field in response
    end
  end

  # Test the /topics endpoint
  describe 'GET /topics' do
    it 'returns a list of topics' do
      get '/topics'

      expect(last_response.status).to eq(200)
      response_body = JSON.parse(last_response.body)

      # Assuming the topics list is an array
      expect(response_body).to be_an(Array)
      expect(response_body.first).to have_key('name')  # Example field in response
    end
  end

  # Test the /helplines endpoint
  describe 'GET /helplines' do
    it 'returns a list of helplines' do
      get '/helplines?country_code=usa&limit=5'

      expect(last_response.status).to eq(200)
      response_body = JSON.parse(last_response.body)

      # Assuming the helplines list is an array
      expect(response_body).to be_an(Array)
      expect(response_body.first).to have_key('name')  # Example field in response
    end
  end

  # Test the /helplines/:id endpoint
  describe 'GET /helplines/:id' do
    it 'returns details of a specific helpline' do
      # Use a valid helpline ID from the API
      valid_helpline_id = '123e4567-e89b-12d3-a456-426655440000'
      get "/helplines/#{valid_helpline_id}"

      expect(last_response.status).to eq(200)
      response_body = JSON.parse(last_response.body)

      # Ensure the response contains specific keys like name and phoneNumber
      expect(response_body).to have_key('name')
      expect(response_body).to have_key('phoneNumber')
    end
  end
end