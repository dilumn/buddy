require 'sinatra/base'
require_relative 'boot'

class Application < Sinatra::Base

  run! if app_file == $0
end