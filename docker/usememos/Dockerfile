# Frontend
FROM node:21-alpine AS frontend

ENV MEMOS_VERSION=0.17.1

WORKDIR /frontend

RUN apk --no-cache add curl \
    && curl -sL -o memos.tar.gz https://github.com/usememos/memos/archive/refs/tags/v${MEMOS_VERSION}.tar.gz \
    && tar zxvf memos.tar.gz \
    && mv memos-${MEMOS_VERSION} memos \
    && cd /frontend/memos/web/src/locales \
    && find . -name '*.json' ! -name 'en.json' ! -name 'zh-*.json' | xargs -I '%%' sh -c 'echo "{}" > %%' \
    && cd /frontend/memos/web \
    && corepack enable && pnpm i --frozen-lockfile && pnpm type-gen \
    && pnpm build \
    && rm -rf /frontend/memos/server/dist && cp -Rf /frontend/memos/web/dist /frontend/memos/server/dist \
    && rm -rf /frontend/memos.tar.gz

# Backend
FROM golang:1.21-alpine AS backend

WORKDIR /backend

COPY --from=frontend /frontend/memos /backend/memos

RUN cd /backend/memos \
    && CGO_ENABLED=0 go build -o memos ./main.go

# Production
FROM alpine:latest AS memos

ENV TZ="UTC"

WORKDIR /memos

RUN apk add --no-cache tzdata \
    && mkdir /var/opt/memos

COPY --from=backend /backend/memos/memos ./memos

VOLUME /var/opt/memos

EXPOSE 5230

ENTRYPOINT ["./memos", "--mode=prod", "--port=5230", "--data=/var/opt/memos", "--metric=false"]
