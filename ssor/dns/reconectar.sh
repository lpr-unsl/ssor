#!/bin/bash
if [ -z "$1" ]
then
	echo " ingresar el nombre exacto del contenedor a reconectar"
	exit 
fi

contenedor=`docker ps -a|egrep $1 |  wc -l`

if [ $contenedor -eq 1 ]
then
        docker start $1
	xterm -T "$1" -fa monaco -fs 11 -e "docker exec -it $1 bash" &
else
	echo "no econtré ese contenedor desconectado de la pantalla"
	exit 
		
fi


#para saber los nombres de los contenedores que estan corriendo
# docker ps  --format "table {{.Names}}"
