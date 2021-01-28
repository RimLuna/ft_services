FROM alpine:3.7

RUN apk --no-cache update \
&& apk add --no-cache mariadb mariadb-client openrc

EXPOSE 3306

CMD ["sh", "/srcs/setup.sh"]