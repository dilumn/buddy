# frozen_string_literal: true

require 'rubygems'
# require 'bundler/setup'

# Bundler.require(:default)

Dir[File.expand_path('../../app/**/*.rb', __FILE__)].each do |app|
  require app
end

require_relative 'schedule'
