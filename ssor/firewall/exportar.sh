#!/bin/bash
if [ -z "$1" ]
then
	echo " ingresar el directorio de exportacion ........ es necesario:"
	docker images  --format "table {{.Repository}} \t   {{  .Size}} "| egrep fire
	exit 
fi
docker save -o $1/fire-latoma.tar fire-latoma 
gzip $1/fire-latoma.tar 
echo "listo latoma"
docker save -o $1/fire-merlo.tar fire-merlo
gzip $1/fire-merlo.tar
echo "listo merlo"
docker save -o $1/fire-potrero.tar fire-potrero
gzip $1/fire-potrero.tar
echo "listo potrero"
docker save -o $1/fire-laflorida.tar fire-laflorida
gzip $1/fire-laflorida.tar
echo "listo laflorida"
docker save -o $1/fire-desaguadero.tar fire-desaguadero
gzip $1/fire-desaguadero.tar
echo "listo desaguadero"
docker save -o $1/fire-nogoli.tar fire-nogoli
gzip $1/fire-nogoli.tar
echo "listo nogoli"


#para saber los nombres de los contenedores que estan corriendo
# docker ps  --format "table {{.Names}}"
