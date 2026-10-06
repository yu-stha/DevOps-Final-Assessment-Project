FROM nginxinc/nginx-unprivileged:stable-alpine

COPY --chown=nginx:nginx html/ /usr/share/nginx/html/

EXPOSE 8080

HEALTHCHECK --interval=30s --timeout=3s --retries=3 \
  CMD wget -qO- http://127.0.0.1:8080/ || exit 1