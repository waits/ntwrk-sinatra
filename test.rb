require './bandwidth.rb'
require 'minitest/autorun'
require 'rack/test'

class BandwidthTest < Minitest::Test
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
    assert_equal '{"ip":"127.0.0.1","host":""}', last_response.body
  end
end
