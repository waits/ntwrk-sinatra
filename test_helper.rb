ENV['RACK_ENV'] = 'test'

require 'rubygems'
require 'bundler/setup'

Bundler.require(:default, :test)

require File.expand_path '../ntwrk.rb', __FILE__
