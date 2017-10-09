# frozen_string_literal: true

ApiDocServer::Engine.routes.draw do
  scope format: false do
    resources :docs, path: '/', only: %i(index show) do
      collection do
        get 'oauth2', to: 'docs#oauth2', format: false
      end
    end

    root to: 'docs#index'
  end
end
