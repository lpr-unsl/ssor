#!/bin/bash
version=`cat /root/Documents/version.txt`
puente=`brctl show | egrep lan1`
if [ -z "$puente" ]
then
	brctl addbr lan1
	brctl addbr lan2
	brctl addbr lan3
	brctl addbr ppp1
	brctl addbr ppp2
	brctl addbr man1
fi

ip link set dev lan1 up
ip link set dev lan2 up
ip link set dev lan3 up
ip link set dev ppp1 up
ip link set dev ppp2 up
ip link set dev man1 up

montaje=`df -h | egrep docker`
if [ -z "$montaje" ]
then
	service docker stop
	mount $1 /var/lib/docker
	service docker start
fi
/sbin/iptables -P FORWARD ACCEPT
contenedores=`docker ps -aq|wc -l`

if [ $contenedores -gt 0 ]
then
	docker stop $(docker ps -aq)
	docker rm $(docker ps -aq)
fi

imagenes=`docker images| egrep dns | wc -l`
if [ $imagenes -gt 0 ]
then
	docker rmi dns-latoma
	docker rmi dns-laflorida
	docker rmi dns-nogoli
	docker rmi dns-desaguadero
	docker rmi dns-potrero
	docker rmi dns-merlo
fi


docker run --detach --hostname latoma -it --name latoma --cap-add NET_ADMIN --env="DISPLAY" --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" cliente:$version bash
docker run --detach --hostname laflorida -it --name laflorida --cap-add NET_ADMIN --privileged servidor:$version bash
docker run --detach --hostname nogoli -it --name nogoli --cap-add NET_ADMIN --privileged servidor:$version bash
docker run --detach --hostname desaguadero -it --name desaguadero --cap-add NET_ADMIN --privileged servidor:$version bash
docker run --detach --hostname potrero -it --name potrero --cap-add NET_ADMIN --privileged servidor:$version bash
docker run --detach --hostname merlo -it --name merlo --cap-add NET_ADMIN cliente-cli:$version bash

docker exec -it latoma ip ro del default
docker exec -it laflorida ip ro del default
docker exec -it nogoli ip ro del default
docker exec -it desaguadero ip ro del default
docker exec -it potrero ip ro del default
docker exec -it merlo ip ro del default

pipework lan2 -i lan2 latoma 0.0.0.0/24
pipework lan2 -i lan2 potrero 0.0.0.0/24
pipework lan1 -i lan1 merlo  0.0.0.0/24
pipework lan1 -i lan1 potrero 0.0.0.0/24
pipework ppp1 -i ppp1 potrero 0.0.0.0/24
pipework ppp1 -i ppp1 laflorida 0.0.0.0/24
pipework man1 -i man1 laflorida 0.0.0.0/24
pipework man1 -i man1 nogoli 0.0.0.0/24
pipework man1 -i man1 desaguadero 0.0.0.0/24


xterm -T "latoma" -fa monaco -fs 11 -e "docker attach latoma" &
xterm -T "laflorida" -fa monaco -fs 11 -e "docker attach laflorida" &
xterm -T "nogoli" -fa monaco -fs 11 -e "docker attach nogoli" &
xterm -T "desaguadero" -fa monaco -fs 11 -e "docker attach desaguadero" &
xterm -T "potrero" -fa monaco -fs 11 -e "docker attach potrero" &
xterm -T "merlo" -fa monaco -fs 11 -e "docker attach merlo" &


#para saber los nombres de los contenedores que estan corriendo
# docker ps  --format "table {{.Names}}"
