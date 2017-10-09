$LOAD_PATH.push File.expand_path('../lib', __FILE__)

require 'api_doc_server/version'

Gem::Specification.new do |s|
  s.name        = 'api_doc_server'
  s.version     = ApiDocServer::VERSION
  s.authors     = ['Benjamin Fleischer']
  s.email       = ['github@benjaminfleischer.com']
  s.homepage    = 'https://github.com/bf4/api_doc_server'
  s.summary     = 'Mountable Rails engine that serves API Docs for your Swagger/OpenAPI docs.'
  s.description = s.summary
  s.license     = 'MIT'

  s.files         = `git ls-files -z`.split("\x0")
  s.test_files    = s.files.grep(%r{^(test|spec|features)/})
  s.require_paths = ['lib']
  s.executables   = []

  s.required_ruby_version = '>= 2.1'

  s.add_runtime_dependency 'rails', ['>= 4.2', '< 6']

  s.add_development_dependency 'rubocop'
end
