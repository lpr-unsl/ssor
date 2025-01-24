#!/bin/bash
if [ -z "$1" ]
then
	echo " ingresar el nombre exacto del contenedor a reconectar"
	exit 
fi

contenedor=`docker ps -a|egrep $1 | egrep Exited | wc -l`

if [ $contenedor -eq 1 ]
then
        docker start $1
	xterm -T "$1" -fa monaco -fs 11 -e "docker attach $1" &
else
	echo "no econtré ese contenedor desconectado de la pantalla"
	exit 
		
fi


#para saber los nombres de los contenedores que estan corriendo
# docker ps  --format "table {{.Names}}"
