require 'rubygems'
require 'bundler'

Bundler.require(:default, :production)

require './ntwrk.rb'
run Sinatra::Application
