 require 'sinatra'
 require 'sinatra/json'
 require 'faraday'
 require 'dotenv/load' # To load environment variables

# # Define routes to communicate with Throughlinecare API
# get '/countries' do
#   response = Faraday.get('https://api.throughlinecare.com/v1/countries', {}, {
#     'Accept' => 'application/json',
#     'Content-Type' => 'application/json'
#   })

#   json response.body
# end

# get '/topics' do
#   response = Faraday.get('https://api.throughlinecare.com/v1/topics', {}, {
#     'Accept' => 'application/json',
#     'Content-Type' => 'application/json'
#   })

#   json response.body
# end

# get '/helplines' do
#   country_code = params['country_code'] || 'usa'  # Default to 'usa'
#   limit = params['limit'] || 20

#   response = Faraday.get("https://api.throughlinecare.com/v1/helplines?country_code=#{country_code}&limit=#{limit}", {}, {
#     'Accept' => 'application/json',
#     'Content-Type' => 'application/json'
#   })

#   json response.body
# end

# get '/helplines/:id' do
#   helpline_id = params[:id]

#   response = Faraday.get("https://api.throughlinecare.com/v1/helplines/#{helpline_id}", {}, {
#     'Accept' => 'application/json',
#     'Content-Type' => 'application/json'
#   })

#   if response.status == 200
#     json response.body
#   else
#     halt 404, json({ error: 'Helpline not found' })
#   end
# end

