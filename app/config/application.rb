# frozen_string_literal: true

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'api'))
$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'boot'
require 'base'
require 'rack'

# provides the documentation of the API
class DocApp
  def call(env)
    @env = env
    [200, { 'Content-Type' => 'text/html' }, [template]]
  end

  def template
    prefix = Api::Base.prefix ? "/#{Api::Base.prefix}" : ''
    "<!DOCTYPE html>
    <html>
      <head>
        <title>ReDoc API documentation</title>
        <meta name='viewport' content='width=device-width, initial-scale=1'>
        <style>body {margin: 0;padding: 0;}</style>
      </head>
      <body>
        <redoc spec-url='http://#{server}:#{port}#{prefix}/#{Api::Base.version}/oapi.json'></redoc>
        <script src='https://rebilly.github.io/ReDoc/releases/v1.17.0/redoc.min.js'> </script>
      </body>
    </html>"
  end

  def server
    @env['SERVER_NAME']
  end

  def port
    @env['SERVER_PORT']
  end
end

# provides the routing between the API and the ReDoc documentation of it
class App < Rack::Attack
  def initialize
    @apps = {}
  end

  def valid_req(env)
    if Api::Base.recognize_path(env['REQUEST_PATH'])
      Api::Base.call(env)
    elsif env['REQUEST_PATH'] == '/doc' && valid_env?(env)
      DocApp.new.call(env)
    else
      [403, { 'Content-Type': 'text/plain' }, ['403 Forbidden']]
    end
  end

  def call(env)
    req = Rack::Attack::Request.new(env)

    if safelisted?(req)
      valid_req(env)
    elsif blocklisted?(req)
      self.class.blocklisted_response.call(env)
    elsif throttled?(req)
      self.class.throttled_response.call(env)
    else
      tracked?(req)
      valid_req(env)
    end
  end

  def valid_env?(env)
    return false if env['RACK_ENV'] == "staging" || env['RACK_ENV'] == "production"
    return true
  end

end
