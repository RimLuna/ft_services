# ft_services
Fucking services I guess.

Nope.
## I'm really really bad at Docker too???
### the point is to keep the containers small
I suppose that was the point of Alpine as the base image, but *whyyyyyyyy*

Using simple details like **--no-cache** to preven apk from caching the index locally

or **apk update** in the beginning and **rm -rf /var/cache/apk/\*** in the end

The point of caching is probably to allow that multiple containers mount the same cache file system without having to redownload it from the net, but it's not worth it I claim, *I claim??? shit I need to lay off philosophy debates for a while*, because you'd need to update the cache everytime anyway for more recent versions

I will use **--no-cache** because it looks prettier

## setting it up, fuck alpine, and ft_server was a useless project
so for **openrc**, you get weird errors while just fucking trying to list status of services, like 
```
awk: /etc/network/interfaces: No such file or directory
```
WTF, turns out, **Docker containers typically run a single service, and don't start an "init" process for managing services via /etc/init.d. To start nginx, you would just run the nginx command instead of its init.d script.**, so, **ft_server** was fucking useless
````
FROM alpine:3.7

RUN apk --no-cache update && \
    apk --no-cache add nginx

RUN mkdir -p /run/nginx

RUN mkdir /usr/share/nginx/html

COPY etc/nginx.conf /etc/nginx/nginx.conf
COPY html/index.html /usr/share/nginx/html/index.html
COPY etc/conf.d/default.conf /etc/nginx/conf.d/default.conf

CMD ["nginx", "-g", "daemon off;"]
````
I'm sticking with this, until I find out what the fuck is going on.

## the ports? in the subject
```
FTPS port 21
MySQL port 3306
Wordpress port 5050
Phpmyadmin port 5000
Grafana port 3000
InfluxDB port 8086
Nginx port 80(HTTP), 443 (SSL) and 22 (SSH)
```

**fucking kill me**, 