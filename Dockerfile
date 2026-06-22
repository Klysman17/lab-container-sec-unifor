FROM nginx:1.27-alpine

# Slide 8 (principio 01 - Atualizar): corrige CVE-2026-31789 (CRITICAL)
# em libcrypto3/libssl3, atualizando o OpenSSL para a versao fixed (3.3.7-r0)
RUN apk update && apk upgrade --no-cache

RUN addgroup -S appgroup && adduser -S appuser -G appgroup

COPY app/ /usr/share/nginx/html/

RUN chown -R appuser:appgroup /usr/share/nginx/html

USER appuser

EXPOSE 8080

HEALTHCHECK --interval=30s --timeout=3s \
  CMD wget -qO- http://localhost:8080 || exit 1
