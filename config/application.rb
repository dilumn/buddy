require 'sinatra/base'
require_relative 'boot'

class Application < Sinatra::Base
  # ... app code here ...

  # start the server if ruby file executed directly
  run! if app_file == $0
end