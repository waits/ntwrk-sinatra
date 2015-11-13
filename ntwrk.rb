require 'sinatra'
require 'json'
require 'resolv'
require 'maxminddb'

get '/' do
  [200, 'Welcome to ntwrk.waits.io']
end

get '/info.json' do
  ip = params[:ip] || request.ip
  resolver = Resolv::DNS.new(:nameserver => ['8.8.8.8', '8.8.4.4'])
  host = resolver.getnames(ip).join(',')

  db = MaxMindDB.new('/var/local/GeoLite2-City.mmdb')
  result = db.lookup(ip)
  country = result.country.name
  region = result.subdivisions.first
  region_name = region ? region.name : nil
  city = result.city.name

  content_type :json
  { :ip => ip, :host => host, :country => country, :region => region_name, :city => city }.to_json
end

post '/upload' do
  `sudo rm #{env['HTTP_X_FILE']}`
  [200, 'OK']
end
