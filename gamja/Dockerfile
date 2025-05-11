FROM --platform=$BUILDPLATFORM docker.io/library/golang:alpine AS kimchi-build

WORKDIR /src

ARG KIMCHI_REF=master
ADD https://codeberg.org/emersion/kimchi.git#${KIMCHI_REF} /src/

ARG TARGETOS TARGETARCH TARGETVARIANT
COPY build-kimchi.sh .
RUN --mount=type=cache,target=/root/.cache/go-build \
	--mount=type=cache,target=/root/go/pkg/mod \
	./build-kimchi.sh


FROM --platform=$BUILDPLATFORM docker.io/library/node:alpine AS gamja-build

WORKDIR /src

ARG GAMJA_REF=master
ADD https://codeberg.org/emersion/gamja.git#${GAMJA_REF} /src/

COPY build-gamja.sh .
RUN --mount=type=cache,target=/root/.npm \
	--mount=type=cache,target=/src/node_modules \
	--mount=type=cache,target=/src/.parcel-cache \
	./build-gamja.sh

FROM scratch AS gamja

COPY --from=kimchi-build /src/kimchi /kimchi
COPY --from=gamja-build /src/dist /gamja

COPY kimchi-config /kimchi-config
COPY gamja-config.json /gamja-config.json

CMD ["/kimchi", "-config", "/kimchi-config"]
