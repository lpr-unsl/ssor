#!/bin/bash

#puente=`brctl show | egrep lan1`
#if [ -z "$puente" ]
#then
	#brctl addbr lan1
	#brctl addbr lan2
	#brctl addbr lan3
	#brctl addbr ppp1
	#brctl addbr ppp2
	#brctl addbr man1
#fi

#ip link set dev lan1 up
#ip link set dev lan2 up
#ip link set dev lan3 up
#ip link set dev ppp1 up
#ip link set dev ppp2 up
#ip link set dev man1 up
#
montaje=`df -h | egrep docker`
if [ -z "$montaje" ]
then
        echo -n " falta montar la particion con las imagenes, especifique el dispositivo: "
	read dispositivo
	service docker stop
	mount $dispositivo /var/lib/docker
	service docker start
fi

contenedores=`docker ps -aq|wc -l`

if [ $contenedores -gt 0 ]
then
	docker stop $(docker ps -aq)
	docker rm $(docker ps -aq)
fi

imagenes=`docker images| egrep smb | wc -l`
if [ $imagenes -gt 0 ]
then
	docker rmi smb-latoma
	docker rmi smb-potrero
fi


docker run --detach --hostname latoma -it --name latoma --cap-add NET_ADMIN cliente:1.6 bash
docker run --detach --hostname potrero -it --name potrero --cap-add NET_ADMIN cliente-cli:1.6 bash

docker exec -it latoma ip ro del default
docker exec -it potrero ip ro del default

#pipework lan2 -i lan2 latoma 0.0.0.0/24
#pipework lan2 -i lan2 potrero 0.0.0.0/24
#pipework lan1 -i lan1 merlo  0.0.0.0/24
#pipework lan1 -i lan1 potrero 0.0.0.0/24
#pipework ppp1 -i ppp1 potrero 0.0.0.0/24
#pipework ppp1 -i ppp1 laflorida 0.0.0.0/24
#pipework man1 -i man1 laflorida 0.0.0.0/24
#pipework man1 -i man1 nogoli 0.0.0.0/24
#pipework man1 -i man1 desaguadero 0.0.0.0/24


xterm -T "latoma" -fa monaco -fs 11 -e "docker attach latoma" &
xterm -T "potrero" -fa monaco -fs 11 -e "docker attach potrero" &


#para saber los nombres de los contenedores que estan corriendo
# docker ps  --format "table {{.Names}}"
