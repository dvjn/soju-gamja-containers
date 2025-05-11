FROM --platform=$BUILDPLATFORM docker.io/library/golang:alpine AS soju-build

RUN --mount=type=cache,target=/var/cache/apk \
	apk -U add build-base ca-certificates tzdata

WORKDIR /src

ARG SOJU_REF=master
ADD https://codeberg.org/emersion/soju.git#${SOJU_REF} /src/

ARG TARGETOS TARGETARCH TARGETPLATFORM BUILDPLATFORM
COPY build-soju.sh .
RUN --mount=type=cache,target=/root/.cache/go-build \
	--mount=type=cache,target=/root/go/pkg/mod \
	./build-soju.sh

FROM scratch AS soju

COPY --from=soju-build /src/soju /src/sojudb /src/sojuctl /
COPY --from=soju-build /usr/share/zoneinfo /usr/share/zoneinfo
COPY --from=soju-build /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/

ENV PATH=/

ENTRYPOINT ["soju"]
HEALTHCHECK CMD ["sojuctl", "help"]
