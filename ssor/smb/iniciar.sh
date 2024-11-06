#!/bin/bash
version=`cat ../../version.txt`
#puente=`docker network list | egrep lan1`
#if [ -z "$puente" ]
#then
#	docker network create -d bridge lan1 --subnet 192.168.1.0/24 --gateway 192.168.1.254 --label lan1 --opt com.docker.network.bridge.name=lan1 --opt com.docker.network.container_iface_prefix=lan1
#	docker network create -d bridge lan2 --subnet 172.16.4.0/23 --gateway 172.16.4.254 --label lan2 --opt com.docker.network.bridge.name=lan2 --opt com.docker.network.container_iface_prefix=lan2
#	docker network create -d bridge lan3 --subnet 10.22.0.0/16 --gateway 10.22.255.254 --label lan3 --opt com.docker.network.bridge.name=lan3 --opt com.docker.network.container_iface_prefix=lan3
#	docker network create -d bridge ppp1 --subnet 200.8.4.16/29 --gateway 200.8.4.22 --label ppp1 --opt com.docker.network.bridge.name=ppp1 --opt com.docker.network.container_iface_prefix=ppp1
#	docker network create -d bridge ppp2 --subnet 170.0.2.0/29 --gateway 170.0.2.1 --label ppp2 --opt com.docker.network.bridge.name=ppp2 --opt com.docker.network.container_iface_prefix=ppp2
#	docker network create -d bridge man1 --subnet 8.8.8.0/28 --gateway 8.8.8.2 --label man1 --opt com.docker.network.bridge.name=man1 --opt com.docker.network.container_iface_prefix=man1
#fi

contenedores=`docker ps -aq|wc -l`

if [ $contenedores -gt 0 ]
then
	docker stop $(docker ps -aq)
	docker rm $(docker ps -aq)
fi

imagenes=`docker images| egrep http | wc -l`
if [ $imagenes -gt 0 ]
then
	docker rmi http-latoma
	docker rmi http-merlo
	docker rmi http-potrero
	docker rmi http-laflorida
	docker rmi http-desaguadero
	docker rmi http-nogoli
	docker rmi http-carrizal
	docker rmi http-laslenias
fi

docker create --network=bridge --hostname latoma --name latoma -it --cap-add NET_ADMIN --env="DISPLAY" --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" cliente:$version
docker create --network=bridge --hostname potrero --name potrero -it --cap-add NET_ADMIN router:$version
#

xterm -T "latoma" -fa monaco -fs 11 -e "docker start -ia latoma" &
xterm -T "potrero" -fa monaco -fs 11 -e "docker start -ia potrero" &

not_running=`docker ps -a | egrep Created`
while [ -n "$not_running" ]
do
	sleep 1
	#echo Waiting until all containers are running
	not_running=`docker ps -a | egrep Created`
done

docker exec -it latoma ip ro del default
docker exec -it potrero ip ro del default


#para saber los nombres de los contenedores que estan corriendo
# docker ps  --format "table {{.Names}}"

