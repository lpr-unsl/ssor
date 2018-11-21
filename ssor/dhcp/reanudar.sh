#!/bin/bash 

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

contenedores=`docker ps -aq|wc -l`

if [ $contenedores -gt 0 ]
then

	docker stop $(docker ps -aq)
	docker rm $(docker ps -aq)

fi
/sbin/iptables -P FORWARD ACCEPT
docker run --detach --hostname latoma -it --name latoma --cap-add NET_ADMIN --env="DISPLAY" --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" dhcp-latoma bash
docker run --detach --hostname clienteLan2 -it --name clienteLan2 --cap-add NET_ADMIN dhcp-clientelandos bash
docker run --detach --hostname potrero -it --name potrero --cap-add NET_ADMIN --privileged dhcp-potrero bash
#docker run --detach --hostname laflorida -it --name laflorida --cap-add NET_ADMIN --privileged dhcp-laflorida bash
docker run --detach --hostname merlo -it --name merlo --cap-add NET_ADMIN dhcp-merlo bash
docker run --detach --hostname clienteLan1 -it --name clienteLan1 --cap-add NET_ADMIN dhcp-clientelanuno bash
docker run --detach --hostname sanfelipe -it --name sanfelipe --cap-add NET_ADMIN --privileged dhcp-sanfelipe bash

docker exec -it latoma ip ro del default
docker exec -it clienteLan2 ip ro del default
docker exec -it potrero ip ro del default
#docker exec -it laflorida ip ro del default
docker exec -it merlo ip ro del default
docker exec -it clienteLan1 ip ro del default
docker exec -it sanfelipe ip ro del default

pipework lan2 -i lan2 latoma 0.0.0.0/24
pipework lan2 -i lan2 clienteLan2 0.0.0.0/24
pipework lan2 -i lan2 potrero 0.0.0.0/24
pipework lan1 -i lan1 potrero 0.0.0.0/24
#pipework ppp1 -i ppp1 potrero 0.0.0.0/24
#pipework ppp1 -i ppp1 laflorida 0.0.0.0/24
pipework lan1 -i lan1 merlo  0.0.0.0/24
pipework lan1 -i lan1 clienteLan1 0.0.0.0/24
pipework lan2 -i lan2 sanfelipe 0.0.0.0/24

#por problemas de checksum de udp
docker exec -it potrero ethtool -K lan2 tx off 1>/dev/null
docker exec -it sanfelipe ethtool -K lan2 tx off 1>/dev/null


xterm -T "latoma" -fa monaco -fs 11 -e "docker attach latoma" &
xterm -T "clienteLan2" -fa monaco -fs 11 -e "docker attach clienteLan2" &
xterm -T "potrero" -fa monaco -fs 11 -e "docker attach potrero" &
#xterm -T "laflorida" -fa monaco -fs 11 -e "docker attach laflorida" &
xterm -T "merlo" -fa monaco -fs 11 -e "docker attach merlo" &
xterm -T "clienteLan1" -fa monaco -fs 11 -e "docker attach clienteLan1" &
xterm -T "sanfelipe" -fa monaco -fs 11 -e "docker attach sanfelipe" &


#para saber los nombres de los contenedores que estan corriendo
# docker ps  --format "table {{.Names}}"
