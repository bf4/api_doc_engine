module SwaggerUiEngine
  class Engine < ::Rails::Engine
    isolate_namespace SwaggerUiEngine

    config.to_prepare do
      Rails.application.config.assets.precompile += %w(
        swagger_ui_engine/redoc.js
        swagger_ui_engine/redoc.map
      )
    end
  end
end
