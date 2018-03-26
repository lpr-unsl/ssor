#!/bin/bash
if [ -z "$1" ]
then
	echo " ingresar el directorio de exportacion ........ es necesario:"
	docker images  --format "table {{.Repository}} \t   {{  .Size}} "| egrep dhcp
	exit 
fi
docker save -o $1/dhcp-latoma.tar dhcp-latoma 
gzip $1/dhcp-latoma.tar 
echo "listo latoma"
docker save -o $1/dhcp-clientelandos.tar dhcp-clientelandos
gzip $1/dhcp-clientelandos.tar
echo "listo clientelan2"
docker save -o $1/dhcp-potrero.tar dhcp-potrero
gzip $1/dhcp-potrero.tar
echo "listo potrero"
docker save -o $1/dhcp-merlo.tar dhcp-merlo
gzip $1/dhcp-merlo.tar
echo "listo merlo"
docker save -o $1/dhcp-clientelanuno.tar dhcp-clientelanuno
gzip $1/dhcp-clientelanuno.tar
echo "listo clientelan1"
docker save -o $1/dhcp-sanfelipe.tar dhcp-sanfelipe
gzip $1/dhcp-sanfelipe.tar
echo "listo sanfelipe"


#para saber los nombres de los contenedores que estan corriendo
# docker ps  --format "table {{.Names}}"
