FROM alpine:3.12

RUN apk add --update \
    python3 \
    && rm -rf /var/cache/apk/*

COPY ddns.py requirements.txt /

RUN pip3 install -r /requirements.txt

CMD ["python3", "/ddns.py"]
