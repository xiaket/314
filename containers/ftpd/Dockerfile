FROM debian:bookworm-slim

RUN apt-get update -qq && \
	apt-get install -y proftpd && \
	apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN sed -i "s/# DefaultRoot/DefaultRoot /" /etc/proftpd/proftpd.conf

EXPOSE 20 21

ADD entrypoint.sh /usr/local/sbin/entrypoint.sh
ENTRYPOINT ["/usr/local/sbin/entrypoint.sh"]

CMD ["proftpd", "--nodaemon"]
