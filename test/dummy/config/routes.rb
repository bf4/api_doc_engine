Rails.application.routes.draw do
  mount ApiDocServer::Engine => '/swagger'
end
