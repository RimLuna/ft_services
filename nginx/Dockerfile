
FROM alpine:latest

RUN apk --no-cache update && \
    apk --no-cache add nginx

RUN mkdir -p /run/nginx \
    && apk add --no-cache openssh-server openrc git rsync \
    && mkdir -p /run/openrc \
    && touch /run/openrc/softlevel

ENTRYPOINT ["sh","-c", "rc-status; rc-service nginx start; crond -f"]