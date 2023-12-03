FROM caddy:2.7.5-builder AS builder

RUN xcaddy build \
    --with github.com/caddy-dns/cloudflare \
    --with github.com/WeidiDeng/caddy-cloudflare-ip

FROM caddy:2.7.5

RUN apk add nss-tools

COPY --from=builder /usr/bin/caddy /usr/bin/caddy
