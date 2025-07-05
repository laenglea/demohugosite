FROM alpine:latest

# Version definieren (anpassbar oder per Build-Argument)
ARG HUGO_VERSION=0.147.9

# Benötigte Tools installieren
RUN apk add --no-cache curl tar bash

# Hugo herunterladen und entpacken
#RUN curl -L https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_${HUGO_VERSION}_linux-amd64.tar.gz \
 #   | tar -xz -C /usr/local/bin hugo

# Hugo installieren
RUN apk add --no-cache --repository=https://dl-cdn.alpinelinux.org/alpine/edge/community hugo

# Arbeitsverzeichnis
WORKDIR /site

# Projektdateien in Container kopieren
COPY ./hugosite /site

# Hugo-Build ausführen
RUN hugo --minify

# Leichtgewichtiger Webserver zum Ausliefern
RUN apk add --no-cache busybox-extras
CMD ["httpd", "-f", "-p", "80", "-h", "/site/public"]

