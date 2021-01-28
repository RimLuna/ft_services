
FROM alpine:3.7

RUN apk --no-cache update && \
    apk --no-cache add nginx openssl openssh &&\
    apk add --no-cache --upgrade bash

## ssh need to be properly setup for user stalin
RUN ssh-keygen -A

## adduser for ssh
RUN adduser \
    -D \
    -h "/www" \
    -H \
    stalin

COPY srcs/passwd.sh /passwd.sh
RUN chmod +x /passwd.sh

## add nginx user
RUN adduser -D -g 'www' www

## stupid nginx useless shit, that won't work unless u add them
RUN mkdir /www && chown -R www:www /var/lib/nginx && chown -R www:www /www && mkdir /run/nginx \
    && chmod a+w /www

COPY srcs/default.conf /etc/nginx/conf.d
COPY srcs/index.html /www

RUn mkdir /etc/nginx/snippets
COPY srcs/ssl-params.conf /etc/nginx/snippets/ssl-params.conf

RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048\
  -keyout /nginx-selfsigned.key \
  -out /nginx-selfsigned.crt \
  -subj "/C=MA/ST=Stalingrad/L=-/O=-/CN=127.0.0.1"

COPY srcs/script.sh /script.sh
RUN chmod +x /script.sh 

EXPOSE 80 443 22

CMD ["sh", "/script.sh"]

## docker run -it -p 8000:80 -p 2222:22 -p 4043:443 alpine-nginx