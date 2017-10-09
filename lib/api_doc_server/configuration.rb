# frozen_string_literal: true

module ApiDocServer
  class Configuration
    OPTIONS = %i(
      authentication_proc
      swagger_urls
      doc_config
    ).freeze

    attr_accessor(*OPTIONS)

    def default_swagger_urls
      {v1: 'http://petstore.swagger.io/v2/swagger.json'}
    end

    def doc_config
      @doc_config ||= {}
    end
  end
end
