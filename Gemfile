source "https://rubygems.org"

gem "sinatra"
gem "haml", :require => "tilt/haml"
gem "maxminddb"

group :test do
  gem "minitest", :require => "minitest/autorun"
  gem "rack-test", :require => "rack/test"
end

group :production do
  gem "unicorn"
end
