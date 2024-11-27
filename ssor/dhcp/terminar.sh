#!/bin/bash

contenedores=`docker ps -aq|wc -l`

if [ $contenedores -gt 0 ]
then
	docker stop $(docker ps -aq)
	docker rm $(docker ps -aq)
fi

#service docker stop
#umount /var/lib/docker

#para saber los nombres de los contenedores que estan corriendo
# docker ps  --format "table {{.Names}}"
