require './ntwrk.rb'
require 'minitest/autorun'
require 'rack/test'

class NtwrkTest < Minitest::Test
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  def test_root
    get '/'
    assert_equal 200, last_response.status
  end

  def test_ip
    get '/ip'
    assert_equal 200, last_response.status
    assert_match /<h2>127\.0\.0\.1<\/h2>/, last_response.body

    get '/ip.txt'
    assert_equal 200, last_response.status
    assert_match '127.0.0.1', last_response.body

    get '/ip.json'
    assert_equal 200, last_response.status
    assert_equal '{"ip":"127.0.0.1"}', last_response.body
  end

  def test_info
    get '/info?ip=8.8.8.8'
    assert_equal 200, last_response.status
    assert_match /<h2>8\.8\.8\.8<\/h2>/, last_response.body

    get '/info.txt?ip=8.8.8.8'
    assert_equal 200, last_response.status
    assert_equal "8.8.8.8\ngoogle-public-dns-a.google.com\nMountain View, California, United States\n37.386, -122.0838\nAmerica/Los_Angeles", last_response.body

    get '/info.json?ip=8.8.8.8'
    assert_equal 200, last_response.status
    assert_equal '{"ip":"8.8.8.8","host":"google-public-dns-a.google.com","country":"United States","region":"California","city":"Mountain View","latitude":37.386,"longitude":-122.0838,"time_zone":"America/Los_Angeles"}', last_response.body
  end
end
