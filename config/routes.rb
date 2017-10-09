# frozen_string_literal: true

ApiDocServer::Engine.routes.draw do
  scope format: false do
    resources :docs, path: '/', only: %i(index show)
    root to: 'docs#index'
  end
end
