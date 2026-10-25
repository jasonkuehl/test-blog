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
COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=build /project/public /usr/share/nginx/html
EXPOSE 80
HEALTHCHECK --interval=30s --timeout=3s CMD wget -q -O /dev/null http://127.0.0.1/healthz || exit 1
