FROM caddy:2.7.5-builder AS builder

RUN xcaddy build \
    --with github.com/caddy-dns/cloudflare

FROM caddy:2.7.5

RUN apk add nss-tools

COPY --from=builder /usr/bin/caddy /usr/bin/caddy
