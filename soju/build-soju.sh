#! /usr/bin/env sh

set -e

if [ "$TARGETPLATFORM" = "$BUILDPLATFORM" ]; then
    tags=""
    ldflags="-linkmode=external -extldflags=-static"
else
    tags="moderncsqlite"
    ldflags=""
    # Workaround for https://todo.sr.ht/~emersion/soju/246
    case "$SOJU_REF" in
    v0.9.*)
        go get modernc.org/sqlite@v1.35.0
        ;;
    esac
fi
export GOOS=$TARGETOS GOARCH=$TARGETARCH
if [ "$TARGETARCH" = arm ]; then
    export GOARM="${TARGETVARIANT##v}"
fi
ldflags="$ldflags -X codeberg.org/emersion/soju/config.DefaultPath=/soju-config"
ldflags="$ldflags -X codeberg.org/emersion/soju/config.DefaultUnixAdminPath=/soju-admin.sock"
go build -o . -tags="$tags" -ldflags="$ldflags" ./cmd/...
