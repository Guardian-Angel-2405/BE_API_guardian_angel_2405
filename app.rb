require 'sinatra'
require 'sinatra/json'
require 'faraday'
require 'dotenv/load'
require './serializers/helpline_serializer'
require 'json'

# Method to fetch the access token
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
    JSON.parse(response.body)['access_token']
  else
    halt 500, json({ error: 'Unable to fetch access token' })
  end
end

# Endpoint to fetch countries
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

# Endpoint to fetch topics
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

# Endpoint to fetch helplines by country code and limit
get '/helplines' do
  token = get_access_token
  country_code = params['country_code'] || 'us'
  limit = params['limit'] || 20

  response = Faraday.get("https://api.throughlinecare.com/v1/helplines?country_code=#{country_code}&limit=#{limit}") do |req|
    req.headers['Authorization'] = "Bearer #{token}"
    req.headers['Accept'] = 'application/json'
  end

  if response.status == 200
    helplines = JSON.parse(response.body)['helplines']
    serialized_helplines = helplines.map do |helpline|
      HelplineSerializer.new(helpline).serialize_index
    end
    json serialized_helplines
  else
    halt response.status, json({ error: 'Unable to fetch helplines' })
  end
end

# Endpoint to fetch helpline details by ID
get '/helplines/:id' do
  token = get_access_token
  helpline_id = params[:id]

  response = Faraday.get("https://api.throughlinecare.com/v1/helplines/#{helpline_id}") do |req|
    req.headers['Authorization'] = "Bearer #{token}"
    req.headers['Accept'] = 'application/json'
  end

  if response.status == 200
    helpline = JSON.parse(response.body)['helpline']
    serialized_helpline = HelplineSerializer.new(helpline).serialize_show
    json serialized_helpline
  else
    halt response.status, json({ error: 'Unable to fetch helpline details' })
  end
end
