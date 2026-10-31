# syntax=docker/dockerfile:1
# Builds the Hugo site and serves it with nginx.
#   docker build -t site .                        # uses baseurl from config/_default/config.toml
#   docker build --build-arg BASE_URL=https://example.com -t site .
#   docker run -p 8080:80 site

ARG HUGO_VERSION=0.160.1
ARG NGINX_VERSION=1.30

FROM ghcr.io/gohugoio/hugo:v${HUGO_VERSION} AS build
ARG BASE_URL=""
ENV HUGO_ENVIRONMENT=production
# The Hugo image runs as the unprivileged "hugo" user in /project
COPY --chown=hugo:hugo . /project
RUN if [ -f package-lock.json ] || [ -f npm-shrinkwrap.json ]; then npm ci; fi \
 && hugo --gc --minify ${BASE_URL:+--baseURL "$BASE_URL"}

FROM nginx:${NGINX_VERSION}-alpine
# Base images lag behind Alpine security fixes; apply them so the Trivy scan passes
# hadolint ignore=DL3017
RUN apk upgrade --no-cache
# Run as the unprivileged nginx user. It can still listen on port 80: Docker lets
# containers bind low ports without root (net.ipv4.ip_unprivileged_port_start=0).
RUN sed -i -e '/^user /d' -e 's#^pid .*#pid /tmp/nginx.pid;#' /etc/nginx/nginx.conf \
    && chown -R nginx:nginx /var/cache/nginx
COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=build /project/public /usr/share/nginx/html
USER nginx
EXPOSE 80
HEALTHCHECK --interval=30s --timeout=3s CMD wget -q -O /dev/null http://127.0.0.1/healthz || exit 1
