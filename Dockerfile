# ---- Stage 1: Get Xray binary ----
FROM ghcr.io/xtls/xray-core:latest AS builder

# ---- Stage 2: Alpine runtime ----
FROM alpine:latest

RUN apk add --no-cache ca-certificates tzdata

COPY --from=builder /usr/bin/xray /usr/local/bin/xray
COPY --from=builder /usr/share/xray/geosite.dat /usr/local/share/xray/geosite.dat
COPY --from=builder /usr/share/xray/geoip.dat /usr/local/share/xray/geoip.dat

WORKDIR /etc/xray

COPY config.json /etc/xray/config.json
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

ENV PORT=3000
EXPOSE 3000

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
