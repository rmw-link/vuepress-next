#!/usr/bin/env bash

DIR=$(cd "$(dirname "$0")"; pwd)
set -ex
cd $DIR
yarn build
rsync -av $DIR/lib/ ~/rmw/blog-vuepress2/node_modules/@vuepress/theme-default/lib/
