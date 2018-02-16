FROM alpine:3.7

ADD https://repo.openpdu.org/alpine/devel@openpdu.org-5a7816cb.rsa.pub /etc/apk/keys

RUN echo "https://repo.openpdu.org/alpine/v3.7/main" >> /etc/apk/repositories && \
    apk --no-cache -U upgrade && \
    apk --no-cache -U add acf-openpdu alpine-base && \
    echo root:root | chpasswd && \
    setup-acf

#ADD start.sh /

EXPOSE 443

#ENTRYPOINT ["/bin/sh"]
ENTRYPOINT ["/usr/sbin/mini_httpd","-D","-C","/etc/mini_httpd/mini_httpd.conf"]

