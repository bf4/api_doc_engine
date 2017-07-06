module SwaggerUiEngine
  module AuthConfigParser
    delegate :admin_username, to: :configuration

    delegate :admin_password, to: :configuration

    def basic_authentication_enabled?
      admin_username && admin_password
    end

    def configuration
      SwaggerUiEngine.configuration
    end
  end
end
