module SwaggerUiEngine
  class Engine < ::Rails::Engine
    isolate_namespace SwaggerUiEngine

    config.to_prepare do
      Rails.application.config.assets.precompile += %w(
        swagger_ui_engine/swagger-ui.css
        swagger_ui_engine/swagger-ui-bundle.js
        swagger_ui_engine/swagger-ui-standalone-preset.js
        swagger_ui_engine/favicon-32x32.png
        swagger_ui_engine/favicon-16x16.png
      )
    end
  end
end
