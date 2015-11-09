require 'sinatra'
require 'json'
require 'resolv'



get '/' do
  [200, 'Welcome to bandwidth.waits.io']
end

get '/info.json' do
  ip = request.ip
  resolver = Resolv::DNS.new(:nameserver => ['8.8.8.8', '8.8.4.4'])
  host = resolver.getnames(ip).join(',')

  content_type :json
  { :ip => ip, :host => host }.to_json
end

post '/upload' do
  `sudo rm #{env['HTTP_X_FILE']}`
  [200, 'OK']
end
