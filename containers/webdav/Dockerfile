FROM resin/armhf-alpine:3.6

RUN apk add --update \
    apache2-webdav \
		bash \
		less \
	&& rm -rf /var/cache/apk/*

COPY httpd-foreground /usr/local/bin/

EXPOSE 80
CMD ["httpd-foreground"]
