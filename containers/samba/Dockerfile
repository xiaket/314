FROM balenalib/rpi-alpine:3.8

RUN apk add --update \
    samba-common-tools \
    samba-client \
    samba-server \
    && rm -rf /var/cache/apk/*
    
EXPOSE 137/udp 138/udp 139 445
ENTRYPOINT ["smbd", "--foreground", "--log-stdout", "--no-process-group"]
