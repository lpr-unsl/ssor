#!/bin/bash
if [ -z "$1" ]
then
	echo " ingresar el directorio de exportacion ........ es necesario:"
	docker images  --format "table {{.Repository}} \t   {{  .Size}} "| egrep smb
	exit 
fi
docker save -o $1/smb-latoma.tar smb-latoma 
gzip $1/smb-latoma.tar 
echo "listo latoma"
docker save -o $1/smb-potrero.tar smb-potrero
gzip $1/smb-potrero.tar
echo "listo potrero"


#para saber los nombres de los contenedores que estan corriendo
# docker ps  --format "table {{.Names}}"
