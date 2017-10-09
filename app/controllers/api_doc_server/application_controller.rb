# frozen_string_literal: true

module ApiDocServer
  class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
    layout 'layouts/swagger'

    if ApiDocServer.configuration.authentication_proc
      before_action :authenticate_admin

      protected

      def authenticate_admin
        instance_exec(&ApiDocServer.configuration.authentication_proc)
      end
    end
  end
end
