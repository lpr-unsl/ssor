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


imagenes=`docker images| egrep http | wc -l`
if [ $imagenes -gt 0 ]
then

	docker rmi http-latoma 
	docker rmi http-merlo
	docker rmi http-potrero
	docker rmi http-laflorida
	docker rmi http-desaguadero
	docker rmi http-nogoli
	docker rmi http-carrizal
	docker rmi http-laslenias

fi

#gunzip $1/http-latoma.tar.gz
docker load -i $1/http-latoma.tar.gz
echo "listo latoma"
#gunzip $1/http-merlo.tar
docker load -i $1/http-merlo.tar.gz
echo "listo merlo"
#gunzip $1/http-potrero.tar
docker load -i $1/http-potrero.tar.gz
echo "listo potrero"
#gunzip $1/http-laflorida.tar
docker load -i $1/http-laflorida.tar.gz
echo "listo laflorida"
#gunzip $1/http-desaguadero.tar
docker load -i $1/http-desaguadero.tar.gz
echo "listo desaguadero"
#gunzip $1/http-nogoli.tar
docker load -i $1/http-nogoli.tar.gz
echo "listo nogoli"
#gunzip $1/http-carrizal.tar
docker load -i $1/http-carrizal.tar.gz
echo "listo carrizal"
#gunzip $1/http-laslenias.tar
docker load -i $1/http-laslenias.tar.gz
echo "listo laslenias"



#para saber los nombres de los contenedores que estan corriendo
# docker ps  --format "table {{.Names}}"
