#! /usr/bin/env sh

set -e
export GOOS=$TARGETOS GOARCH=$TARGETARCH
if [ "$TARGETARCH" = arm ]; then
    export GOARM="${TARGETVARIANT##v}"
fi
go build
