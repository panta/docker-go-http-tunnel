FROM golang:alpine AS builder

MAINTAINER Marco Pantaleoni <marco.pantaleoni@gmail.com>

ENV LANG=C.UTF-8

RUN apk -U add --no-cache \
	git ca-certificates && \
	go get -v github.com/mmatczuk/go-http-tunnel/cmd/tunneld github.com/mmatczuk/go-http-tunnel/cmd/tunnel \
	&& rm -rf /var/cache/apk/*

# final stage
FROM alpine

WORKDIR /

RUN apk -U add --no-cache \
	openssl ca-certificates \
	&& rm -rf /var/cache/apk/* 

COPY --from=builder /go/bin/tunneld /go/bin/tunnel /usr/bin/

# default variables
ENV COUNTY "US"
ENV STATE "New Jersey"
ENV LOCATION "Piscataway"
ENV ORGANISATION "Ecample"
ENV ROOT_CN "Root"
ENV ISSUER_CN "Example Ltd"
ENV PUBLIC_CN "example.com"
ENV ROOT_NAME "root"
ENV ISSUER_NAME "example"
ENV PUBLIC_NAME "public"
ENV RSA_KEY_NUMBITS "2048"
ENV DAYS "365"

# certificate directories
ENV CERT_DIR "/etc/ssl/certs"

ENV TUNNEL_CONFIG /tunnel.yml

RUN mkdir -p /.tunnel

VOLUME ["$CERT_DIR"]

COPY *.ext /
COPY entrypoint.sh / 
COPY tunneld.sh / 
RUN chmod a+x /entrypoint.sh && \
	chmod a+x /tunneld.sh

ENTRYPOINT [ "/entrypoint.sh" ]
