#!/usr/bin/env bash

DIR=$(cd "$(dirname "$0")"; pwd)
set -ex
cd $DIR

npx copy-and-watch packages/@vuepress/theme-default ../blog-vuepress2/node_modules/@vuepress/theme-default --watch
