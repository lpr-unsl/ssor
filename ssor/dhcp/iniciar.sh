#!/bin/bash
#version=`cat ../../version.txt`
version=2.0
puente=`docker network list | egrep lan1`
if [ -z "$puente" ]
then
	docker network create -d bridge lan1 --subnet 192.168.1.0/24 --gateway 192.168.1.254 --label lan1 --opt com.docker.network.bridge.name=lan1 --opt com.docker.network.container_iface_prefix=lan1
	docker network create -d bridge lan2 --subnet 172.16.4.0/23 --gateway 172.16.4.254 --label lan2 --opt com.docker.network.bridge.name=lan2 --opt com.docker.network.container_iface_prefix=lan2
	docker network create -d bridge lan3 --subnet 10.22.0.0/16 --gateway 10.22.255.254 --label lan3 --opt com.docker.network.bridge.name=lan3 --opt com.docker.network.container_iface_prefix=lan3
	docker network create -d bridge ppp1 --subnet 200.8.4.16/29 --gateway 200.8.4.22 --label ppp1 --opt com.docker.network.bridge.name=ppp1 --opt com.docker.network.container_iface_prefix=ppp1
	docker network create -d bridge ppp2 --subnet 170.0.2.0/29 --gateway 170.0.2.1 --label ppp2 --opt com.docker.network.bridge.name=ppp2 --opt com.docker.network.container_iface_prefix=ppp2
	docker network create -d bridge man1 --subnet 8.8.8.0/28 --gateway 8.8.8.2 --label man1 --opt com.docker.network.bridge.name=man1 --opt com.docker.network.container_iface_prefix=man1
fi

contenedores=`docker ps -aq|wc -l`

if [ $contenedores -gt 0 ]
then
	docker stop $(docker ps -aq)
	docker rm $(docker ps -aq)
fi

imagenes=`docker images| egrep dhcp | wc -l`
if [ $imagenes -gt 0 ]
then
	docker rmi dhcp-latoma
	docker rmi dhcp-clientelandos
	docker rmi dhcp-potrero
	#docker rmi dhcp-laflorida
	docker rmi dhcp-merlo
	docker rmi dhcp-clientelanuno
	docker rmi dhcp-sanfelipe
fi

docker create --network=bridge --hostname latoma --name latoma -it --cap-add NET_ADMIN --env="DISPLAY" --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" cliente:$version
docker create --network=bridge --hostname clienteLan2 --name clienteLan2 -it --cap-add NET_ADMIN cliente-cli:$version
docker create --network=bridge --hostname potrero --name potrero -it --cap-add NET_ADMIN --privileged servidor:$version
docker create --network=bridge --hostname merlo --name merlo -it --cap-add NET_ADMIN cliente-cli:$version
docker create --network=bridge --hostname clienteLan1 --name clienteLan1 -it --cap-add NET_ADMIN cliente-cli:$version
docker create --network=bridge --hostname sanfelipe --name sanfelipe -it --cap-add NET_ADMIN --privileged servidor:$version

#
docker network connect lan1 potrero
docker network connect lan1 clienteLan1
docker network connect lan1 merlo
docker network connect lan2 potrero
docker network connect lan2 latoma
docker network connect lan2 clienteLan2
docker network connect lan2 sanfelipe

xterm -T "merlo" -fa monaco -fs 11 -e "docker start -ia merlo" &
xterm -T "clienteLan1" -fa monaco -fs 11 -e "docker start -ia clienteLan1" &
xterm -T "potrero" -fa monaco -fs 11 -e "docker start -ia potrero" &
xterm -T "latoma" -fa monaco -fs 11 -e "docker start -ia latoma" &
xterm -T "clienteLan2" -fa monaco -fs 11 -e "docker start -ia clienteLan2" &
xterm -T "sanfelipe" -fa monaco -fs 11 -e "docker start -ia sanfelipe" &

not_running=`docker ps -a | egrep Created`
while [ -n "$not_running" ]
do
	sleep 1
	#echo Waiting until all containers are running
	not_running=`docker ps -a | egrep Created`
done

docker exec -it merlo ip ro del default
docker exec -it clienteLan1 ip ro del default
docker exec -it potrero ip ro del default
docker exec -it latoma ip ro del default
docker exec -it clienteLan2 ip ro del default
docker exec -it sanfelipe ip ro del default

docker exec -it merlo ifconfig lan10 0.0.0.0
docker exec -it clienteLan1 ifconfig lan10 0.0.0.0
docker exec -it potrero ifconfig lan10 0.0.0.0
docker exec -it potrero ifconfig lan20 0.0.0.0
docker exec -it latoma ifconfig lan20 0.0.0.0
docker exec -it clienteLan2 ifconfig lan20 0.0.0.0
docker exec -it sanfelipe ifconfig lan20 0.0.0.0
#para saber los nombres de los contenedores que estan corriendo
# docker ps  --format "table {{.Names}}"

