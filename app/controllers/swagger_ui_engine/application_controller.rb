module SwaggerUiEngine
  class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
    layout 'layouts/swagger'

    if SwaggerUiEngine.configuration.authentication_proc
      before_action :authenticate_admin

      protected

      def authenticate_admin
        SwaggerUiEngine.configuration.authentication_proc.call(self)
      end
    end
  end
end
