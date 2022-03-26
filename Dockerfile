FROM golang:1.18-alpine as builder
WORKDIR /build
COPY go.mod go.sum main.go ./
RUN CGO_ENABLED=0 go build -ldflags="-extldflags=-static"

FROM alpine
COPY --from=builder /build/caddy-with-auth /usr/bin/caddy
VOLUME [ "/Caddyfile" ]

CMD [ "caddy", "run", "-config", "/Caddyfile" ]
