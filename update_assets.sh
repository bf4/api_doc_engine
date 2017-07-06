#!/usr/bin/env bash

# Usage:
#  1. npm install
#  1. ./update_assets.sh
#  1. review any changes manually, ignoring where where the engine adds configurations
#    - NOTE: the dist/index.html is split into
#      - assets/javascripts/application.js
#      - assets/stylesheets/application.js
#      - assets/stylesheets/print.js
#      - views/layouts/swagger.html.erb
#      - views/swagger_ui_engine/docs/show.html.erb
#      - views/swagger_ui_engine/docs/index.html.erb
DIST_PATH="node_modules/swagger-ui/dist"
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
add_image_tags() {
ruby -e "
  filename = '$ASSETS_PATH/$1'
  contents = File.read(filename).gsub(/url\(\.\.\/images\/(?<image>[^)]+)\)/) do %(url(\"<=% image_path('swagger_ui_engine/#{Regexp.last_match[1]}') %>\")); end
  File.write(filename, contents)
"

}
strip_trailing_whitespace() {
  git ls-files app/assets/**/*{erb,css,html,js} | while read file ; do sed -i '' -e's/[[:space:]]*$//' "$file"; done
}
# node_modules/swagger-ui/dist/
# ├── css
# ├── fonts
# ├── images
# ├── lang
# ├── lib
# ├── index.html
# ├── o2c.html
# ├── swagger-ui.js
# └── swagger-ui.min.js
copy_asset /swagger-ui.js /javascripts/swagger_ui_engine/
copy_asset /swagger-ui.min.js /javascripts/swagger_ui_engine/

cp node_modules/swagger-ui/dist/o2c.html app/views/swagger_ui_engine/docs/oauth2.html.erb
cp node_modules/swagger-ui/dist/index.html app/views/swagger_ui_engine/docs/index.html.erb

# node_modules/swagger-ui/dist/lib/
# ├── backbone-min.js
# ├── es5-shim.js
# ├── handlebars-4.0.5.js
# ├── highlight.9.1.0.pack.js
# ├── highlight.9.1.0.pack_extended.js
# ├── jquery-1.8.0.min.js
# ├── jquery.ba-bbq.min.js
# ├── jquery.slideto.min.js
# ├── jquery.wiggle.min.js
# ├── js-yaml.min.js
# ├── jsoneditor.min.js
# ├── lodash.min.js
# ├── marked.js
# ├── object-assign-pollyfill.js
# ├── sanitize-html.min.js
# └── swagger-oauth.js
copy_asset /lib/* /javascripts/swagger_ui_engine/lib/

# node_modules/swagger-ui/dist/css/
# ├── print.css -> print.css.erb
# ├── reset.css
# ├── screen.css -> screen.css.erb
# ├── style.css
# └── typography.css -> typography.css.erb
copy_asset /css/print.css /stylesheets/swagger_ui_engine/lib/print.css.erb
beautify_css /stylesheets/swagger_ui_engine/lib/print.css.erb
add_image_tags /stylesheets/swagger_ui_engine/lib/print.css.erb

copy_asset /css/screen.css  /stylesheets/swagger_ui_engine/lib/screen.css.erb
beautify_css /stylesheets/swagger_ui_engine/lib/screen.css.erb
add_image_tags /stylesheets/swagger_ui_engine/lib/screen.css.erb

# copy_asset /css/typography.css /stylesheets/swagger_ui_engine/lib/typography.css.erb
copy_asset /css/reset.css /stylesheets/swagger_ui_engine/lib/reset.css
copy_asset /css/style.css /stylesheets/swagger_ui_engine/lib/style.css

# node_modules/swagger-ui/dist/fonts/
# ├── DroidSans-Bold.ttf
# └── DroidSans.ttf
copy_asset /fonts/* /fonts/swagger_ui_engine/

# node_modules/swagger-ui/dist/images/
# ├── collapse.gif
# ├── expand.gif
# ├── explorer_icons.png
# ├── favicon-16x16.png
# ├── favicon-32x32.png
# ├── favicon.ico
# ├── logo_small.png
# ├── pet_store_api.png
# ├── throbber.gif
# └── wordnik_api.png
copy_asset /images/* /images/swagger_ui_engine/

# node_modules/swagger-ui/dist/lang/
# ├── ca.js
# ├── el.js
# ├── en.js
# ├── es.js
# ├── fr.js
# ├── geo.js
# ├── it.js
# ├── ja.js
# ├── ko-kr.js
# ├── pl.js
# ├── pt.js
# ├── ru.js
# ├── tr.js
# ├── translator.js
# └── zh-cn.js
copy_asset /lang/* /javascripts/swagger_ui_engine/lang

# Strip trailing whitespace
strip_trailing_whitespace
