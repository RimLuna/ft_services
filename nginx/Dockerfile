
FROM alpine:latest

RUN apk --no-cache update && \
    apk --no-cache add nginx

RUN mkdir -p /run/nginx \
    && apk add --no-cache openssh-server openrc git rsync \
    && mkdir -p /run/openrc \
    && touch /run/openrc/softlevel

RUN mkdir /usr/share/nginx/html

COPY etc/nginx.conf /etc/nginx/nginx.conf
COPY html/index.html /usr/share/nginx/html/index.html
COPY etc/conf.d/default.conf /etc/nginx/conf.d/default.conf

ENTRYPOINT ["sh","-c", "rc-status; rc-service nginx start; crond -f"]