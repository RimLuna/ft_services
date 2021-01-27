
FROM alpine:3.7

RUN apk --no-cache update && \
    apk --no-cache add nginx &&\
    apk add --no-cache --upgrade bash &&\
    apk add --no-cache openssl openssh

RUN mkdir -p /run/nginx

RUN mkdir -p /www
COPY ./index.html /www

COPY ./etc/nginx.conf /etc/nginx/nginx.conf
COPY etc/conf.d/default.conf /etc/nginx/conf.d/default.conf

EXPOSE 80 443 22

CMD ["/bin/bash"]