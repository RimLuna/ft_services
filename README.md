# ft_services
Fucking services I guess.

Nope.
## I'm really really bad at Docker too???
### the point is to keep the containers small
Using simple details like **--no-cache** to preven apk from caching the index locally

or **apk update** in the beginning and **rm -rf /var/cache/apk/\*** in the end

The point of cacching is probably to allow that multiple containers mount the same cache file system without having to redownload it from the net, but it's not worth it I claim, *I claim??? shit I need to lay off philosophy debates for a while*, because you'd need to update the cache everytime anyway for more recent versions

I will use **--no-cache** because it looks prettier