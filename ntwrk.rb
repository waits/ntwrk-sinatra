require 'json'
require 'resolv'

def json(hash)
  content_type :json
  hash.to_json
end

def text(str)
  content_type :txt
  str
end

get '/' do
  [200, 'Welcome to ntwrk.waits.io']
end

get '/ip.?:format?' do |fmt|
  @ip = request.ip
  case fmt
    when nil then haml :ip
    when 'txt' then text(@ip)
    when 'json' then json(ip: @ip)
  end
end

get '/info.?:format?' do |fmt|
  @ip = params[:ip] || request.ip
  resolver = Resolv::DNS.new(:nameserver => ['8.8.8.8', '8.8.4.4'])
  @host = resolver.getnames(@ip).join(',')

  db = MaxMindDB.new('./GeoLite2-City.mmdb')
  result = db.lookup(@ip)
  subdivision = result.subdivisions.first

  @country = result.country.name
  @region = subdivision ? subdivision.name : nil
  @city = result.city.name
  @lat = result.location.latitude
  @lon = result.location.longitude
  @tz = result.location.time_zone

  case fmt
    when nil then haml :info
    when 'txt'
     text("#{@ip}\n#{@host}\n#{@city}, #{@region}, #{@country}\n#{@lat}, #{@lon}\n#{@tz}")
    when 'json'
      json(ip: @ip, host: @host, country: @country, region: @region, city: @city, latitude: @lat, longitude: @lon, time_zone: @tz)
  end
end

post '/upload' do
  `sudo rm #{env['HTTP_X_FILE']}`
  [200, 'OK']
end
