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
  region = result.subdivisions.first
  response = {
    :ip => ip,
    :host => host,
    :country => result.country.name,
    :region => region ? region.name : nil,
    :city => result.city.name,
    :latitude => result.location.latitude,
    :longitude => result.location.longitude,
    :time_zone => result.location.time_zone
  }

  content_type :json
  response.to_json
end

post '/upload' do
  `sudo rm #{env['HTTP_X_FILE']}`
  [200, 'OK']
end
