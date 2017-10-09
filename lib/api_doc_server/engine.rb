# frozen_string_literal: true

module ApiDocServer
  class Engine < ::Rails::Engine
    isolate_namespace ApiDocServer

    config.to_prepare do
      Rails.application.config.assets.precompile += %w(
        api_doc_server/redoc.js
        api_doc_server/redoc.map
      )
    end
  end
end
