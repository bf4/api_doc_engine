# frozen_string_literal: true

module SwaggerUiEngine
  VERSION = '2.0.0' unless const_defined?(:VERSION)
  def self.version
    VERSION
  end

  def self.redoc_version
    @redoc_version ||=
      begin
        require 'json'
        lib = File.expand_path('..', __FILE__)
        root = File.expand_path File.join(lib, '..', '..')
        file = File.join(root, 'package.json')
        JSON.parse(File.read(file))
          .fetch("dependencies")
          .fetch("redoc")
      end
  end
end
