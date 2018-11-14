#!/bin/bash
if [ -z "$1" ]
then
	echo " ingresar el directorio donde estan as imagenes tareadas y zipeadas ;-)"
	exit 
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

#gunzip $1/smb-latoma.tar.gz
docker load -i $1/smb-latoma.tar.gz
echo "listo latoma"
#gunzip $1/smb-potrero.tar
docker load -i $1/smb-potrero.tar.gz
echo "listo potrero"


#para saber los nombres de los contenedores que estan corriendo
# docker ps  --format "table {{.Names}}"
