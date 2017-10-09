# frozen_string_literal: true

module ApiDocServer
  class DocsController < ApplicationController
    before_action :set_configs

    def index
      redirect_to doc_path(@swagger_urls.keys.first) if single_doc_url_hash?
    end

    def show
      swagger_url = @swagger_urls[params[:id].to_sym]
      @swagger_config = engine_config.doc_config.merge(
        'spec-url': swagger_url
      ).map do |attribute, value|
        "#{attribute}='#{value}'"
      end.join(' ').html_safe # rubocop:disable Rails/OutputSafety
      render action: :show, layout: 'layouts/swagger'
    end

    private

    def set_configs
      @swagger_urls =
        engine_config.swagger_urls || engine_config.default_swagger_urls
    end

    def single_doc_url_hash?
      @swagger_urls.size == 1
    end

    def engine_config
      @engine_config ||= ApiDocServer.configuration
    end
  end
end
