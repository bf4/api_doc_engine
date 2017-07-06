$LOAD_PATH.push File.expand_path('../lib', __FILE__)

require 'swagger_ui_engine/version'

Gem::Specification.new do |s|
  s.name        = 'swagger_ui_engine'
  s.version     = SwaggerUiEngine::VERSION
  s.authors     = ['ZuzannaSt', 'github@benjaminfleischer.com']
  s.email       = ['zuzannast@gmail.com']
  s.homepage    = 'https://github.com/swipesense/swagger_ui_engine'
  s.summary     = 'Mountable Rails engine that serves Swagger UI for your API documentation written in YAML files.'
  s.description = 'Mount Swagger UI web console as Rails engine, configure it as you want and write your API documentation in simple YAML files.'
  s.license     = 'MIT'

  s.files = Dir[
    '{app,config,db,lib}/**/*',
    'MIT-LICENSE',
    'Rakefile',
    'README.rdoc',
    'CHANGELOG.md'
  ]

  s.add_runtime_dependency 'rails', ['>= 4.2', '<= 5.2.0']

  s.add_development_dependency 'rubocop'
end
