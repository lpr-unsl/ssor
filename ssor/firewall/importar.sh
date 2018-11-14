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


imagenes=`docker images| egrep fire | wc -l`
if [ $imagenes -gt 0 ]
then

	docker rmi fire-latoma 
	docker rmi fire-merlo
	docker rmi fire-potrero
	docker rmi fire-laflorida
	docker rmi fire-desaguadero
	docker rmi fire-nogoli
	docker rmi fire-carrizal
	docker rmi fire-laslenias

fi

#gunzip $1/fire-latoma.tar.gz
docker load -i $1/fire-latoma.tar.gz
echo "listo latoma"
#gunzip $1/fire-merlo.tar
docker load -i $1/fire-merlo.tar.gz
echo "listo merlo"
#gunzip $1/fire-potrero.tar
docker load -i $1/fire-potrero.tar.gz
echo "listo potrero"
#gunzip $1/fire-laflorida.tar
docker load -i $1/fire-laflorida.tar.gz
echo "listo laflorida"
#gunzip $1/fire-desaguadero.tar
docker load -i $1/fire-desaguadero.tar.gz
echo "listo desaguadero"
#gunzip $1/fire-nogoli.tar
docker load -i $1/fire-nogoli.tar.gz
echo "listo nogoli"


#para saber los nombres de los contenedores que estan corriendo
# docker ps  --format "table {{.Names}}"
