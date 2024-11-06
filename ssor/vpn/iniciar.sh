#!/bin/bash
version=`cat ../../version.txt`
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

imagenes=`docker images| egrep vpn | wc -l`
if [ $imagenes -gt 0 ]
then
	docker rmi vpn-latoma
	docker rmi vpn-merlo
	docker rmi vpn-potrero
	docker rmi vpn-laflorida
	docker rmi vpn-desaguadero
	docker rmi vpn-carrizal
	docker rmi vpn-laslenias
fi

docker create --network=bridge --hostname latoma --name latoma -it --cap-add NET_ADMIN --privileged servidor:$version
docker create --network=bridge --hostname merlo --name merlo -it --cap-add NET_ADMIN --privileged servidor:$version
docker create --network=bridge --hostname potrero --name potrero -it --cap-add NET_ADMIN --privileged servidor:$version
docker create --network=bridge --hostname laflorida --name laflorida -it --cap-add NET_ADMIN --env="DISPLAY" --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" cliente:$version
docker create --network=bridge --hostname desaguadero --name desaguadero -it --cap-add NET_ADMIN router:$version
docker create --network=bridge --hostname carrizal --name carrizal -it --cap-add NET_ADMIN --privileged servidor:$version
docker create --network=bridge --hostname laslenias --name laslenias -it --cap-add NET_ADMIN --privileged servidor:$version
#
docker network connect lan1 potrero --ip 192.168.1.1
docker network connect lan1 merlo --ip 192.168.1.48
docker network connect lan2 potrero --ip 172.16.4.1
docker network connect lan2 latoma --ip 172.16.4.10
docker network connect ppp1 potrero --ip 200.8.4.18
docker network connect ppp1 laflorida --ip 200.8.4.17
docker network connect man1 laflorida --ip 8.8.8.14
docker network connect man1 desaguadero --ip 8.8.8.1
docker network connect ppp2 desaguadero --ip 170.0.2.6
docker network connect ppp2 carrizal --ip 170.0.2.5
docker network connect lan3 carrizal --ip 10.22.0.1
docker network connect lan3 laslenias --ip 10.22.0.150

xterm -T "latoma" -fa monaco -fs 11 -e "docker start -ia latoma" &
xterm -T "merlo" -fa monaco -fs 11 -e "docker start -ia merlo" &
xterm -T "potrero" -fa monaco -fs 11 -e "docker start -ia potrero" &
xterm -T "laflorida" -fa monaco -fs 11 -e "docker start -ia laflorida" &
xterm -T "desaguadero" -fa monaco -fs 11 -e "docker start -ia desaguadero" &
xterm -T "carrizal" -fa monaco -fs 11 -e "docker start -ia carrizal" &
xterm -T "laslenias" -fa monaco -fs 11 -e "docker start -ia laslenias" &

not_running=`docker ps -a | egrep Created`
while [ -n "$not_running" ]
do
	sleep 1
	#echo Waiting until all containers are running
	not_running=`docker ps -a | egrep Created`
done

docker exec -it latoma ip ro del default
docker exec -it merlo ip ro del default
docker exec -it potrero ip ro del default
docker exec -it laflorida ip ro del default
docker exec -it desaguadero ip ro del default
docker exec -it carrizal ip ro del default
docker exec -it laslenias ip ro del default

docker exec -it latoma ip ro add default via 172.16.4.1
docker exec -it merlo ip ro add default via 192.168.1.1
docker exec -it potrero ip ro add default via 200.8.4.17
docker exec -it carrizal ip ro add default via 170.0.2.6
docker exec -it laslenias ip ro add default via 10.22.0.1

docker exec -it laflorida ip ro add 192.168.1.0/24 via 200.8.4.18
docker exec -it laflorida ip ro add 172.16.4.0/23 via 200.8.4.18
docker exec -it laflorida ip ro add 10.22.0.0/16 via 8.8.8.1

docker exec -it desaguadero ip ro add 192.168.1.0/24 via 8.8.8.14
docker exec -it desaguadero ip ro add 172.16.4.0/23 via 8.8.8.14
docker exec -it desaguadero ip ro add 10.22.0.0/16 via 170.0.2.5


#para saber los nombres de los contenedores que estan corriendo
# docker ps  --format "table {{.Names}}"

