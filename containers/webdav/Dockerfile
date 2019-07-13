FROM arm32v7/alpine:3.10

RUN apk add --update \
    apache2-ssl \
    apache2-webdav \
    bash \
    less \
    && rm -rf /var/cache/apk/*

EXPOSE 80
EXPOSE 443
COPY httpd-foreground /usr/local/bin/

CMD ["httpd-foreground"]
