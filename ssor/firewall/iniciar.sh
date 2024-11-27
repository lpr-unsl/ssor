#!/bin/bash
version=`cat ../../version.txt`
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

docker create --network=bridge --hostname latoma --name latoma -it --cap-add NET_ADMIN --privileged $hub-servidor-$svc:$version
docker create --network=bridge --hostname merlo --name merlo -it --cap-add NET_ADMIN $hub-cliente-cli:$version
docker create --network=bridge --hostname potrero --name potrero -it --cap-add NET_ADMIN --privileged $hub-servidor-$svc:$version
docker create --network=bridge --hostname laflorida --name laflorida -it --cap-add NET_ADMIN --privileged $hub-servidor-$svc:$version
docker create --network=bridge --hostname nogoli --name nogoli -it --cap-add NET_ADMIN --privileged $hub-servidor-$svc:$version
docker create --network=bridge --hostname desaguadero --name desaguadero -it --cap-add NET_ADMIN --privileged $hub-servidor-$svc:$version

docker network connect lan1 merlo --ip 192.168.1.48
docker network connect lan1 potrero --ip 192.168.1.1
docker network connect lan2 potrero --ip 172.16.4.1
docker network connect lan2 latoma --ip 172.16.4.10
docker network connect ppp1 potrero --ip 200.8.4.18
docker network connect ppp1 laflorida --ip 200.8.4.17
docker network connect man1 laflorida --ip 8.8.8.14
docker network connect man1 nogoli --ip 8.8.8.8
docker network connect man1 desaguadero --ip 8.8.8.1

xterm -T "latoma" -fa monaco -fs 11 -e "docker start -ia latoma" &
xterm -T "laflorida" -fa monaco -fs 11 -e "docker start -ia laflorida" &
xterm -T "nogoli" -fa monaco -fs 11 -e "docker start -ia nogoli" &
xterm -T "desaguadero" -fa monaco -fs 11 -e "docker start -ia desaguadero" &
xterm -T "potrero" -fa monaco -fs 11 -e "docker start -ia potrero" &
xterm -T "merlo" -fa monaco -fs 11 -e "docker start -ia merlo" &

not_running=`docker ps -a | egrep Created`
while [ -n "$not_running" ]
do
	sleep 1
	#echo Waiting until all containers are running
	not_running=`docker ps -a | egrep Created`
done

docker exec -it latoma ip ro del default
docker exec -it laflorida ip ro del default
docker exec -it nogoli ip ro del default
docker exec -it desaguadero ip ro del default
docker exec -it potrero ip ro del default
docker exec -it merlo ip ro del default

docker exec -it latoma ip ro add default via 172.16.4.1
docker exec -it merlo ip ro add default via 192.168.1.1
docker exec -it potrero ip ro add default via 200.8.4.17

docker exec -it laflorida ip ro add 192.168.1.0/24 via 200.8.4.18
docker exec -it laflorida ip ro add 172.16.4.0/23 via 200.8.4.18
docker exec -it laflorida ip ro add 10.22.0.0/16 via 8.8.8.1

docker exec -it desaguadero ip ro add 192.168.1.0/24 via 8.8.8.14
docker exec -it desaguadero ip ro add 172.16.4.0/23 via 8.8.8.14

docker exec -it nogoli ip ro add 192.168.1.0/24 via 8.8.8.14
docker exec -it nogoli ip ro add 172.16.4.0/23 via 8.8.8.14
docker exec -it nogoli ip ro add 10.22.0.0/16 via 8.8.8.1
docker exec -it nogoli ip ro add 200.8.4.16/30 via 8.8.8.14
docker exec -it nogoli ip ro add 170.0.2.4/30 via 8.8.8.1

#para saber los nombres de los contenedores que estan corriendo
# docker ps  --format "table {{.Names}}"

