# ft_services
Fucking services I guess.

Nope.
## I'm really really bad at Docker too???
### the point is to keep the containers small
Using simple details like **--no-cache** to preven apk from caching the index locally

or **apk update** in the beginning and **rm -rf /var/cache/apk/\*** in the end

The point of cacching is probably to allow that multiple containers mount the same cache file system without having to redownload it from the net, but it's not worth it I claim, *I claim??? shit I need to lay off philosophy debates for a while*, because you'd need to update the cache everytime anyway for more recent versions

I will use **--no-cache** because it looks prettier
### issues
So the fucking container builds but of course fucking exits, wtf is this crap.
# Nginx
Running the official nginx docker image
```
➜  nginx git:(main) ✗ docker run -d -p 8080:80 --name fucking-nginx nginx
➜  nginx git:(main) ✗ docker ps -a
CONTAINER ID   IMAGE          COMMAND                  CREATED         STATUS                       PORTS                  NAMES
9e5f3007a7c7   nginx          "/docker-entrypoint.…"   4 seconds ago   Up 4 seconds                 0.0.0.0:8080->80/tcp   fucking-nginx
➜  nginx git:(main) ✗ curl http://localhost:8080/
curl: (7) Failed to connect to localhost port 8080: Connection refused
➜  nginx git:(main) ✗ docker-machine ip default

192.168.99.101
➜  ft_services git:(main) ✗ curl -I http://192.168.99.101:8080
HTTP/1.1 200 OK
Server: nginx/1.19.6
```
So it works like this

Now, let's *copy* the config files from this running shit.
```
➜  nginx git:(main) ✗ docker exec fucking-nginx cat /etc/nginx/nginx.conf
➜  nginx git:(main) ✗ docker exec fucking-nginx cat /etc/nginx/conf.d/default.conf
```
the official nginx image is running on
```
➜  nginx git:(main) ✗ docker exec fucking-nginx cat /etc/os-release               
PRETTY_NAME="Debian GNU/Linux 10 (buster)"
NAME="Debian GNU/Linux"
VERSION_ID="10"
VERSION="10 (buster)"
VERSION_CODENAME=buster
ID=debian
HOME_URL="https://www.debian.org/"
SUPPORT_URL="https://www.debian.org/support"
BUG_REPORT_URL="https://bugs.debian.org/"
```
**kill me**, debian, while we're forced to use **fucking retarded alpine**

Need an nginx user and group for **ssh** later
```
➜  nginx git:(main) ✗ docker exec fucking-nginx cat /etc/passwd
nginx:x:101:101:nginx user,,,:/nonexistent:/bin/false
```
Root directory for serving static pages is **/usr/share/nginx/html/** on debian
### trying to build an nginx:alpine image

```
FROM alpine:latest

RUN apk --no-cache update && \
    apk --no-cache add nginx

RUN mkdir -p /run/nginx \
    && apk add --no-cache openssh-server openrc git rsync \
    && mkdir -p /run/openrc \
    && touch /run/openrc/softlevel

RUN mkdir /usr/share/nginx/html

# RUN rm -rf /etc/nginx/conf.d/default.conf
COPY ./index.html /usr/share/nginx/html/index.html
COPY etc/nginx.conf /etc/nginx/nginx.conf
COPY etc/conf.d/default.conf /etc/conf.d/

ENTRYPOINT ["sh","-c", "rc-status; rc-service nginx start; crond -f"]
```
this dockerfile produces
```
➜  nginx git:(main) ✗ docker build --tag nginx-alpine .
➜  nginx git:(main) ✗ docker run -p 8000:80 -ti --name again nginx-alpine
➜  ft_services git:(main) ✗ curl -I http://192.168.99.101:8080
HTTP/1.1 404 Not Found
Server: nginx/1.18.0
Date: Sun, 24 Jan 2021 17:00:12 GMT
Content-Type: text/html
Content-Length: 153
Connection: keep-alive
```
FUCKING **kill me**, the location directive in the default.conf file returns 404 for route /
```
➜  nginx git:(main) ✗ docker exec khikhi cat /etc/nginx/conf.d/default.conf
        # Everything is a 404
        location / {
                return 404;
        }  
```
nice even though I explicitly copied that shit
