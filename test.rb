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
    get '/info.json'
    assert_equal 200, last_response.status
    assert_equal '{"ip":"127.0.0.1","host":"","country":null,"city":null}', last_response.body
  end

  def test_other_ip
    get '/info.json?ip=8.8.8.8'
    assert_equal 200, last_response.status
    assert_equal '{"ip":"8.8.8.8","host":"google-public-dns-a.google.com","country":"United States","city":"Mountain View"}', last_response.body
  end
end
