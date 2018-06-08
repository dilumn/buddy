# frozen_string_literal: true

module Api
  class Base < Grape::API

    version 'v1', using: :path
    format :json

    rescue_from Grape::Exceptions::ValidationErrors do |error|
      error!({ error: error.full_messages, status: 403 }, 403)
    end

    rescue_from Grape::Exceptions::MethodNotAllowed do |error|
      error!({ error: "method_not_allowed", status: 405 }, 405)
    end

    rescue_from :all do |e|
      Base.logger.error e
      error!({ error: "server_error", status: 500 }, 500)
    end

    add_swagger_documentation format: :json,
                              info: {
                                title: 'Starter API'
                              },
                              mount_path: '/oapi',
                              models: [
                              ]
  end
end
