require 'sinatra'
require 'json'
require 'resolv'
require 'maxminddb'

get '/' do
  [200, 'Welcome to bandwidth.waits.io']
end

get '/info.json' do
  ip = params[:ip] || request.ip
  resolver = Resolv::DNS.new(:nameserver => ['8.8.8.8', '8.8.4.4'])
  host = resolver.getnames(ip).join(',')

  db = MaxMindDB.new('/var/local/GeoLite2-City.mmdb')
  result = db.lookup(ip)
  country = result.country.name
  city = result.city.name

  content_type :json
  { :ip => ip, :host => host, :country => country, :city => city }.to_json
end

post '/upload' do
  `sudo rm #{env['HTTP_X_FILE']}`
  [200, 'OK']
end
