FROM golang:1.16 as builder
RUN curl -L https://github.com/caddyserver/xcaddy/releases/download/v0.1.9/xcaddy_0.1.9_linux_amd64.tar.gz -o xcaddy.tar.gz
RUN tar zxvf xcaddy.tar.gz && mv xcaddy /usr/local/bin
RUN xcaddy build \
    --with github.com/greenpau/caddy-auth-portal@v1.4.6 \
    --with github.com/greenpau/caddy-auth-jwt@v1.2.7

FROM alpine
COPY --from=builder /go/caddy /usr/bin/caddy
VOLUME [ "/Caddyfile" ]

CMD [ "caddy", "run", "-config", "/Caddyfile" ]
