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


imagenes=`docker images| egrep vpn | wc -l`
if [ $imagenes -gt 0 ]
then

	docker rmi vpn-latoma 
	docker rmi vpn-merlo
	docker rmi vpn-potrero
	docker rmi vpn-laflorida
	docker rmi vpn-desaguadero
	docker rmi vpn-carrizal
	docker rmi vpn-laslenias

fi

#gunzip $1/vpn-latoma.tar.gz
docker load -i $1/vpn-latoma.tar.gz
echo "listo latoma"
#gunzip $1/vpn-merlo.tar
docker load -i $1/vpn-merlo.tar.gz
echo "listo merlo"
#gunzip $1/vpn-potrero.tar
docker load -i $1/vpn-potrero.tar.gz
echo "listo potrero"
#gunzip $1/vpn-laflorida.tar
docker load -i $1/vpn-laflorida.tar.gz
echo "listo laflorida"
#gunzip $1/vpn-desaguadero.tar
docker load -i $1/vpn-desaguadero.tar.gz
echo "listo desaguadero"
#gunzip $1/vpn-carrizal.tar
docker load -i $1/vpn-carrizal.tar.gz
echo "listo carrizal"
#gunzip $1/vpn-laslenias.tar
docker load -i $1/vpn-laslenias.tar.gz
echo "listo laslenias"



#para saber los nombres de los contenedores que estan corriendo
# docker ps  --format "table {{.Names}}"
