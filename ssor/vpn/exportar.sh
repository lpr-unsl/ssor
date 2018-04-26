#!/bin/bash
if [ -z "$1" ]
then
	echo " ingresar el directorio de exportacion ........ es necesario:"
	docker images  --format "table {{.Repository}} \t   {{  .Size}} "| egrep vpn
	exit 
fi
docker save -o $1/vpn-latoma.tar vpn-latoma 
gzip $1/vpn-latoma.tar 
echo "listo latoma"
docker save -o $1/vpn-merlo.tar vpn-merlo
gzip $1/vpn-merlo.tar
echo "listo merlo"
docker save -o $1/vpn-potrero.tar vpn-potrero
gzip $1/vpn-potrero.tar
echo "listo potrero"
docker save -o $1/vpn-laflorida.tar vpn-laflorida
gzip $1/vpn-laflorida.tar
echo "listo laflorida"
docker save -o $1/vpn-desaguadero.tar vpn-desaguadero
gzip $1/vpn-desaguadero.tar
echo "listo desaguadero"
docker save -o $1/vpn-carrizal.tar vpn-carrizal
gzip $1/vpn-carrizal.tar
echo "listo carrizal"
docker save -o $1/vpn-laslenias.tar vpn-laslenias
gzip $1/vpn-laslenias.tar
echo "listo laslenias"



#para saber los nombres de los contenedores que estan corriendo
# docker ps  --format "table {{.Names}}"
