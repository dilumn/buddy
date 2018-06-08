# frozen_string_literal: true

require 'rubygems'
require 'bundler/setup'
require 'singleton'
require 'securerandom'

Bundler.require :default, ENV['RACK_ENV']

Dir[File.expand_path('../../config/initializers/*.rb', __FILE__)].each do |initializer|
  require initializer
end

Dir[File.expand_path('../../helpers/*.rb', __FILE__)].each do |helper|
  require helper
end

Dir[File.expand_path('../../models/*.rb', __FILE__)].each do |model|
  require model
end

Dir[File.expand_path('../../lib/*.rb', __FILE__)].each do |lib|
  require lib
end
