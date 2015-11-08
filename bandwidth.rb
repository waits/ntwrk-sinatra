require 'sinatra'
require 'json'

get '/' do
  [200, 'Welcome to bandwidth.waits.io']
end

get '/ip.json' do
  content_type :json
  { :ip => request.ip }.to_json
end

post '/upload' do
  `sudo rm #{env['HTTP_X_FILE']}`
  [200, 'OK']
end
