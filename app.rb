require 'sinatra'
require 'sinatra/json'
require 'faraday'
require 'dotenv/load'
require './serializers/helpline_serializer'
require 'json'

set :port, ENV['PORT'] || 4567

# In-memory cache for token and expiration time
$token_cache = {
  token: nil,
  expires_at: nil
}

# Cache for API responses
$response_cache = {
  countries: nil,
  topics: nil,
  helplines: {}
}

# Method to check if the current token is still valid
def valid_token?
  $token_cache[:token] && Time.now < $token_cache[:expires_at]
end

# Method to generate the OAuth access token
def get_access_token
  # Return the cached token if it's still valid
  if valid_token?
    puts "Current Access Token: #{$token_cache[:token]}"
    return $token_cache[:token]
  end

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
    $token_cache[:token] = token_data['access_token']
    $token_cache[:expires_at] = Time.now + token_data['expires_in'].to_i

    puts "New Access Token: #{$token_cache[:token]}"  # Print the new token to the terminal

    $token_cache[:token] # Return the new token
  else
    halt response.status, json({ error: 'Unable to fetch access token' })
  end
end

# Endpoint to fetch countries
get '/countries' do
  if $response_cache[:countries]
    return json $response_cache[:countries]
  end

  token = get_access_token
  response = Faraday.get("https://api.throughlinecare.com/v1/countries") do |req|
    req.headers['Authorization'] = "Bearer #{token}"
    req.headers['Accept'] = 'application/json'
  end

  if response.status == 200
    $response_cache[:countries] = response.body
    json response.body
  else
    halt response.status, json({ error: 'Unable to fetch countries' })
  end
end

# Endpoint to fetch topics
get '/topics' do
  if $response_cache[:topics]
    return json $response_cache[:topics]
  end

  token = get_access_token
  response = Faraday.get("https://api.throughlinecare.com/v1/topics") do |req|
    req.headers['Authorization'] = "Bearer #{token}"
    req.headers['Accept'] = 'application/json'
  end

  if response.status == 200
    $response_cache[:topics] = response.body
    json response.body
  else
    halt response.status, json({ error: 'Unable to fetch topics' })
  end
end

# Endpoint to fetch helplines by country code and limit
get '/helplines' do
  country_code = params['country_code'] || 'us'
  limit = params['limit'] || 20

  cache_key = "#{country_code}_#{limit}"
  if $response_cache[:helplines][cache_key]
    return json $response_cache[:helplines][cache_key]
  end

  token = get_access_token
  response = Faraday.get("https://api.throughlinecare.com/v1/helplines?country_code=#{country_code}&limit=#{limit}") do |req|
    req.headers['Authorization'] = "Bearer #{token}"
    req.headers['Accept'] = 'application/json'
  end

  if response.status == 200
    helplines = JSON.parse(response.body)['helplines']
    serialized_helplines = helplines.map do |helpline|
      HelplineSerializer.new(helpline).serialize_index
    end
    $response_cache[:helplines][cache_key] = serialized_helplines
    json serialized_helplines
  else
    halt response.status, json({ error: 'Unable to fetch helplines' })
  end
end

# Endpoint to fetch helpline details by ID
get '/helplines/:id' do
  token = get_access_token
  helpline_id = params[:id]

  if $response_cache[:helplines][helpline_id]
    return json $response_cache[:helplines][helpline_id]
  end

  response = Faraday.get("https://api.throughlinecare.com/v1/helplines/#{helpline_id}") do |req|
    req.headers['Authorization'] = "Bearer #{token}"
    req.headers['Accept'] = 'application/json'
  end

  if response.status == 200
    helpline = JSON.parse(response.body)['helpline']
    serialized_helpline = HelplineSerializer.new(helpline).serialize_show
    $response_cache[:helplines][helpline_id] = serialized_helpline
    json serialized_helpline
  else
    halt response.status, json({ error: 'Unable to fetch helpline details' })
  end
end
