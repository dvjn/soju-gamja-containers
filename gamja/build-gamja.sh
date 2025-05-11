#! /usr/bin/env sh

set -e

npm install --include=dev
npm run build
