module SwaggerUiEngine
  VERSION = '1.0.2'.freeze
  def self.swagger_ui_version
    @swagger_ui_version ||=
      begin
        require 'json'
        lib = File.expand_path('..', __FILE__)
        root = File.expand_path File.join(lib, '..', '..')
        file = File.join(root, 'package.json')
        JSON.parse(File.read(file)).fetch("dependencies").fetch("swagger-ui")
      end
  end
end
