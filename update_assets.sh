#!/usr/bin/env bash

# Usage:
#  1. npm install
#  1. ./update_assets.sh
#  1. review any changes manually, ignoring where where the engine adds configurations
#    - NOTE: the index.html is split into
#      - assets/javascripts/application.js
#      - assets/stylesheets/application.css
#      - views/layouts/swagger.html.erb
#      - views/swagger_ui_engine/docs/show.html.erb
#      - views/swagger_ui_engine/docs/index.html.erb
DIST_PATH="node_modules/swagger-ui-dist"
ASSETS_PATH="app/assets"
npm install
command -v beautify || npm install -g beautify

copy_asset() {
  local cmd
  cmd="cp ${DIST_PATH}/$1 ${ASSETS_PATH}/$2"
  eval "$cmd"
}

beautify_css() {
  beautify -o "${ASSETS_PATH}/$1" -f css "${ASSETS_PATH}/$1"
}

beautify_js() {
  beautify -o "${ASSETS_PATH}/$1" -f js "${ASSETS_PATH}/$1"
}

strip_trailing_whitespace() {
  git ls-files app/assets/**/*{erb,css,html,js} | while read file ; do sed -i '' -e's/[[:space:]]*$//' "$file"; done
}

# node_modules/swagger-ui-dist/
# ├── favicon-16x16.png
# ├── favicon-32x32.png
# ├── index.html
# ├── oauth2-redirect.html
# ├── swagger-ui-bundle.js
# ├── swagger-ui-bundle.js.map
# ├── swagger-ui-standalone-preset.js
# ├── swagger-ui-standalone-preset.js.map
# ├── swagger-ui.css
# ├── swagger-ui.css.map
# nodejs artifacts
# ├── absolute-path.js
# ├── index.js
# ├── swagger-ui.js
# └── swagger-ui.js.map

# html
cp node_modules/swagger-ui-dist/oauth2-redirect.html app/views/swagger_ui_engine/docs/oauth2.html.erb
cp node_modules/swagger-ui-dist/index.html app/views/layouts/swagger.html.erb

# javascript
copy_asset /swagger-ui-bundle.js /javascripts/swagger_ui_engine/
copy_asset /swagger-ui-bundle.js.map /javascripts/swagger_ui_engine/
copy_asset /swagger-ui-standalone-preset.js /javascripts/swagger_ui_engine/
copy_asset /swagger-ui-standalone-preset.js.map /javascripts/swagger_ui_engine/
beautify_js /javascripts/swagger_ui_engine/swagger-ui-bundle.js
beautify_js /javascripts/swagger_ui_engine/swagger-ui-standalone-preset.js

# stylesheets
copy_asset /swagger-ui.css /stylesheets/swagger_ui_engine/swagger-ui.css.erb
copy_asset /swagger-ui.css /stylesheets/swagger_ui_engine/swagger-ui.css.map
beautify_css /stylesheets/swagger_ui_engine/swagger-ui.css.erb

# images
copy_asset /*.png /images/swagger_ui_engine/

# Strip trailing whitespace
strip_trailing_whitespace
