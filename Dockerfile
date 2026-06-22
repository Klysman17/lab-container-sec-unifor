FROM nginx:1.27-alpine

RUN addgroup -S appgroup && adduser -S appuser -G appgroup

COPY app/ /usr/share/nginx/html/

RUN chown -R appuser:appgroup /usr/share/nginx/html

USER appuser

EXPOSE 8080

HEALTHCHECK --interval=30s --timeout=3s \
  CMD wget -qO- http://localhost:8080 || exit 1
