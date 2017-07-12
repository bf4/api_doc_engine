# SwaggerUiEngine

Include [redoc](https://github.com/Rebilly/ReDoc) as Rails engine and document your API with simple YAML files. Supports API documentation versioning.

## Installation

Add to Gemfile

```
gem 'swagger_ui_engine'
```

And then run:

```
$ bundle
```

## Usage

### Mount

Add to your `config/routes.rb`

```
mount SwaggerUiEngine::Engine, at: "/api_docs"
```

You can place this route under `admin_constraint` or other restricted path, or configure basic HTTP authentication.

#### Devise auth

```
authenticate :user, lambda { |u| u.admin? } do
  mount SwaggerUiEngine::Engine, at: "/api_docs"
end
```

#### Basic HTTP auth

Set admin username and password in an initializer:

```
# config/initializers/swagger_ui_engine.rb

SwaggerUiEngine.configure do |config|
  config.authentication_proc = proc do |controller|
    authenticate_or_request_with_http_basic do |username, password|
      User.find_by(name: username, password: password)
    end
  end
end
```

### Initialize

#### Versioned API documentations

Set the path of your json/yaml versioned documentations in an initializer:

```
# config/initializers/swagger_ui_engine.rb

SwaggerUiEngine.configure do |config|
  config.swagger_urls = {
    v1: 'api/v1/swagger.yaml',
    v2: 'api/v2/swagger.yaml',
  }
end
```

and place your main documentation file under `/public/api` path.

#### Single API documentation


```
# config/initializers/swagger_ui_engine.rb

SwaggerUiEngine.configure do |config|
  config.swagger_urls = { v1: 'api/v1/swagger.yaml' }
end
```


### Configure
Config Name | Swagger parameter name | Description
--- | --- | ---
config.swagger_url | Hash<version_key,url> | The url pointing `swagger.yaml` (Swagger 2.0) as per [OpenAPI Spec](https://github.com/OAI/OpenAPI-Specification/). This params requires hash value - pass your API doc version name as a key and it's main documentation url as a value.
config.doc_config | Hash<config_attribute,value> | Any of the configs specified in https://github.com/Rebilly/ReDoc#redoc-tag-attributes, e.g. `{ 'scroll-y-offset': 50 }`
config.authentication_proc = | proc | a proc that takes the current controller as an argument and halts rendering per custom strategy.


## License

This project is available under MIT-LICENSE. :sunny:
