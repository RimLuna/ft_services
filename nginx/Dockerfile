FROM alpine

RUN 	apk update\
		&& apk add nginx\
		mkdir -p /run/nginx

COPY 	./start.sh /tmp
EXPOSE 	80

ENTRYPOINT [ "sh start.sh" ]