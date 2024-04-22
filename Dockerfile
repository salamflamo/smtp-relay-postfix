#Dockerfile for a Postfix email relay service
FROM alpine:3.16

RUN apk update && \
    apk add bash gawk cyrus-sasl cyrus-sasl-login cyrus-sasl-crammd5 mailx \
    postfix && \
    rm -rf /var/cache/apk/* && \
    mkdir -p /var/log/supervisor/ /var/run/supervisor/ && \
    sed -i -e 's/inet_interfaces = localhost/inet_interfaces = all/g' /etc/postfix/main.cf

RUN mkdir /etc/certificate/ -p
VOLUME [ "/etc/certificate" ]

COPY run.sh /
RUN chmod +x /run.sh
RUN newaliases

EXPOSE 25
EXPOSE 587
EXPOSE 465
#ENTRYPOINT ["/run.sh"]
CMD ["/run.sh"]
