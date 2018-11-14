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


imagenes=`docker images| egrep smtp | wc -l`
if [ $imagenes -gt 0 ]
then

	docker rmi smtp-latoma 
	docker rmi smtp-potrero
	docker rmi smtp-laflorida
	docker rmi smtp-desaguadero
	docker rmi smtp-carrizal
	docker rmi smtp-laslenias

fi

#gunzip $1/smtp-latoma.tar.gz
docker load -i $1/smtp-latoma.tar.gz
echo "listo latoma"
#gunzip $1/smtp-potrero.tar
docker load -i $1/smtp-potrero.tar.gz
echo "listo potrero"
#gunzip $1/smtp-laflorida.tar
docker load -i $1/smtp-laflorida.tar.gz
echo "listo laflorida"
#gunzip $1/smtp-desaguadero.tar
docker load -i $1/smtp-desaguadero.tar.gz
echo "listo desaguadero"
#gunzip $1/smtp-carrizal.tar
docker load -i $1/smtp-carrizal.tar.gz
echo "listo carrizal"
#gunzip $1/smtp-laslenias.tar
docker load -i $1/smtp-laslenias.tar.gz
echo "listo laslenias"



#para saber los nombres de los contenedores que estan corriendo
# docker ps  --format "table {{.Names}}"
