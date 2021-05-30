FROM golang:1.16 as builder
WORKDIR /build
COPY go.mod go.sum main.go ./
RUN go build -ldflags="-extldflags=-static"

FROM alpine
COPY --from=builder /build/caddy-with-auth /usr/bin/caddy
VOLUME [ "/Caddyfile" ]

CMD [ "caddy", "run", "-config", "/Caddyfile" ]
