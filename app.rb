require 'sinatra'
require 'sinatra/json'
require 'faraday'
require 'dotenv/load'
require 'json'

# Load environment variables from .env
Dotenv.load

# Method to generate the OAuth access token
def get_access_token
  response = Faraday.post("https://api.findahelpline.com/oauth/token") do |req|
    req.headers['Content-Type'] = 'application/x-www-form-urlencoded'
    req.body = {
      grant_type: 'client_credentials',
      client_id: ENV['CLIENT_ID'],
      client_secret: ENV['CLIENT_SECRET']
    }
  end

  if response.status == 200
    token_data = JSON.parse(response.body)
    token_data['access_token'] # Return the access token
  else
    puts response.body # To debug the error response
    halt response.status, json({ error: 'Unable to fetch access token' })
  end
end

# Endpoint to fetch countries from ThroughLine API
get '/countries' do
  token = get_access_token

  response = Faraday.get("https://api.throughlinecare.com/v1/countries") do |req|
    req.headers['Authorization'] = "Bearer #{token}"
    req.headers['Accept'] = 'application/json'
  end

  if response.status == 200
    json response.body
  else
    halt response.status, json({ error: 'Unable to fetch countries' })
  end
end

# Endpoint to fetch topics from ThroughLine API
get '/topics' do
  token = get_access_token

  response = Faraday.get("https://api.throughlinecare.com/v1/topics") do |req|
    req.headers['Authorization'] = "Bearer #{token}"
    req.headers['Accept'] = 'application/json'
  end

  if response.status == 200
    json response.body
  else
    halt response.status, json({ error: 'Unable to fetch topics' })
  end
end

# Endpoint to fetch helplines from ThroughLine API based on country code and limit
get '/helplines' do
  token = get_access_token
  country_code = params['country_code'] || 'usa'  # Default to 'usa'
  limit = params['limit'] || 20

  response = Faraday.get("https://api.throughlinecare.com/v1/helplines?country_code=#{country_code}&limit=#{limit}") do |req|
    req.headers['Authorization'] = "Bearer #{token}"
    req.headers['Accept'] = 'application/json'
  end

  if response.status == 200
    json response.body
  else
    halt response.status, json({ error: 'Unable to fetch helplines' })
  end
end

# Endpoint to fetch details for a specific helpline based on helpline ID
get '/helplines/:id' do
  token = get_access_token
  helpline_id = params[:id]

  response = Faraday.get("https://api.throughlinecare.com/v1/helplines/#{helpline_id}") do |req|
    req.headers['Authorization'] = "Bearer #{token}"
    req.headers['Accept'] = 'application/json'
  end

  if response.status == 200
    json response.body
  else
    halt response.status, json({ error: 'Unable to fetch helpline details' })
  end
end
