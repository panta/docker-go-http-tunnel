FROM golang:alpine AS builder

MAINTAINER DCsunset

RUN apk --no-cache add git ca-certificates && \
	go get -v github.com/mmatczuk/go-http-tunnel/cmd/tunneld github.com/mmatczuk/go-http-tunnel/cmd/tunnel

# final stage
FROM alpine

RUN apk --no-cache add ca-certificates

COPY --from=builder /go/bin/tunneld /go/bin/tunnel /usr/bin/

