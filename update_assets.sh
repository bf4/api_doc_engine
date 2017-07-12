#!/usr/bin/env bash

# Usage:
#  1. npm install
#  1. ./update_assets.sh
#  1. review any changes manually, ignoring where where the engine adds configurations
DIST_PATH="node_modules/redoc/dist"
ASSETS_PATH="app/assets"
npm install
command -v beautify >/dev/null || npm install -g beautify

strip_trailing_whitespace() {
  git ls-files app/assets/**/*{erb,css,html,js} | while read -r file ; do sed -i '' -e's/[[:space:]]*$//' "$file"; done
}

# node_modules/redoc/dist/
# ├── redoc.min.js
# └── redoc.min.map

# javascript
mkdir -p "${ASSETS_PATH}/javascripts/swagger_ui_engine/"
cp "${DIST_PATH}/redoc.min.map" "${ASSETS_PATH}/javascripts/swagger_ui_engine/"
cp "${DIST_PATH}/redoc.min.js" "${ASSETS_PATH}/javascripts/swagger_ui_engine/redoc.min.js"
cp "${DIST_PATH}/redoc.min.js" "${ASSETS_PATH}/javascripts/swagger_ui_engine/redoc.js"

# beautify to more easily see diff
beautify -o "${ASSETS_PATH}/javascripts/swagger_ui_engine/redoc.js" -f js "${ASSETS_PATH}/javascripts/swagger_ui_engine/redoc.js"

# Strip trailing whitespace
strip_trailing_whitespace
