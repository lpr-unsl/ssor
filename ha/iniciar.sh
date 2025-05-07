#!/bin/bash
version=`cat ../version.txt`
#dockerhub repo name
hub=sistemasoperativostur/netoslab
#get ONLY current directory name into a variable
svc=$(pwd | awk -F/ '{print $NF}')
#script to check docker is running or not
docker info > /dev/null 2>&1
if [ $? -ne 0 ]
then
	echo "Docker is not running ...starting docker"
	mount /dev/sda /var/lib/docker
	service docker start
fi

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

docker create --network=bridge --hostname clilan --name clilan -it --cap-add NET_ADMIN --env="DISPLAY" --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" $hub-cliente:$version
docker create --network=bridge --hostname cliint --name cliint -it --cap-add NET_ADMIN --env="DISPLAY" --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" $hub-cliente:$version
docker create --network=bridge --hostname router1 --name router1 -it --cap-add NET_ADMIN $hub-router:$version
docker create --network=bridge --hostname router2 --name router2 -it --cap-add NET_ADMIN $hub-router:$version
#
docker network connect lan2 clilan --ip 172.16.4.200
docker network connect lan2 router1 --ip 172.16.4.7
docker network connect lan2 router2 --ip 172.16.4.8
docker network connect man1 router1 --ip 8.8.8.12
docker network connect man1 router2 --ip 8.8.8.13
docker network connect man1 cliint --ip 8.8.8.8

xterm -T "clilan" -fa monaco -fs 11 -e "docker start -ia clilan" &
xterm -T "cliint" -fa monaco -fs 11 -e "docker start -ia cliint" &
xterm -T "router1" -fa monaco -fs 11 -e "docker start -ia router1" &
xterm -T "router2" -fa monaco -fs 11 -e "docker start -ia router2" &

not_running=`docker ps -a | egrep Created`
while [ -n "$not_running" ]
do
	sleep 1
	#echo Waiting until all containers are running
	not_running=`docker ps -a | egrep Created`
done

docker exec -it cliint ip ro del default
docker exec -it clilan ip ro del default
docker exec -it router1 ip ro del default
docker exec -it router2 ip ro del default


#para saber los nombres de los contenedores que estan corriendo
# docker ps  --format "table {{.Names}}"

