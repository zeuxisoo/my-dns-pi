FROM caddy:2.5.1-builder AS builder

RUN xcaddy build \
    --with github.com/caddy-dns/cloudflare

FROM caddy:2.5.1

RUN apk add nss-tools

COPY --from=builder /usr/bin/caddy /usr/bin/caddy
