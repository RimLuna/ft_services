FROM alpine:3.7

RUN apk --no-cache update \
&& apk add --no-cache php7 php7-fpm php7-opcache \
php7-gd php7-mysqli php7-zlib php7-curl \
php7-mbstring php7-json php7-session

RUN wget https://wordpress.org/latest.tar.gz \
&& tar -xvf latest.tar.gz \
&& rm latest.tar.gz \
&& mkdir /www \
&& mv wordpress/ www/

COPY srcs/wp-config.php /www/wordpress/wp-config.php
COPY srcs/start.sh /start.sh

EXPOSE 5050 80

CMD ["sh", "/setup.sh"]