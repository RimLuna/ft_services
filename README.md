# ft_services: failing to blindly copy googled setup guides

```
docker-machine ls
docker-machine create --driver virtualbox default
mv ~/.docker /tmp/.docker
ln -s /tmp/.docker ~/.docker
ln -s /tmp/.docker ~/Library/Containers/com.docker.docker/Data/com.docker.driver.amd64-linux/Docker.qcow2

cd /sgoinfre/goinfre/Perso/[log-in]/
find . -maxdepth 1 -mindepth 1 -type d -exec du -hs {} \;
# chmod g+rwx .docker -R

docker-machine ls
docker-machine start default
eval $(docker-machine env default)
```

## fucking minikube
```
$ minikube start
$ 