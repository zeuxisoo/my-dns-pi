FROM coredns/coredns:latest AS orignal


FROM alpine:latest

COPY --from=orignal /etc/ssl/certs /etc/ssl/certs
COPY --from=orignal /coredns /coredns

EXPOSE 53 53/udp
ENTRYPOINT ["/coredns"]
