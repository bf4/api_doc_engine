# frozen_string_literal: true

require 'rails/engine'
require 'action_controller/railtie'
require 'api_doc_server/engine'
require 'api_doc_server/version'
require 'api_doc_server/configuration'

module ApiDocServer
  class << self
    delegate(*Configuration::OPTIONS, to: :configuration)

    def configuration
      @configuration ||= Configuration.new
    end

    def configure
      yield configuration
    end
  end
end
