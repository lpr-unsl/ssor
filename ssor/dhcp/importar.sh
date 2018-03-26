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


imagenes=`docker images| egrep dhcp | wc -l`
if [ $imagenes -gt 0 ]
then

	docker rmi dhcp-latoma 
	docker rmi dhcp-clientelandos
	docker rmi dhcp-potrero
	docker rmi dhcp-merlo
	docker rmi dhcp-clientelanuno
	docker rmi dhcp-sanfelipe

fi

gunzip $1/dhcp-latoma.tar.gz
docker load -i $1/dhcp-latoma.tar
echo "listo latoma"
gunzip $1/dhcp-clientelandos.tar
docker load -i $1/dhcp-clientelandos.tar
echo "listo clientelan2"
gunzip $1/dhcp-potrero.tar
docker load -i $1/dhcp-potrero.tar
echo "listo potrero"
gunzip $1/dhcp-merlo.tar
docker load -i $1/dhcp-merlo.tar
echo "listo merlo"
gunzip $1/dhcp-clientelanuno.tar
docker load -i $1/dhcp-clientelanuno.tar
echo "listo clientelan1"
gunzip $1/dhcp-sanfelipe.tar
docker load -i $1/dhcp-sanfelipe.tar
echo "listo sanfelipe"


#para saber los nombres de los contenedores que estan corriendo
# docker ps  --format "table {{.Names}}"
