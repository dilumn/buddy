# frozen_string_literal: true

require 'rubygems'

Dir[File.expand_path('../../app/**/*.rb', __FILE__)].each do |app|
  require app
end
