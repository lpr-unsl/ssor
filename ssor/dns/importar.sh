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


imagenes=`docker images| egrep dns | wc -l`
if [ $imagenes -gt 0 ]
then

	docker rmi dns-latoma 
	docker rmi dns-laflorida
	docker rmi dns-nogoli
	docker rmi dns-desaguadero
	docker rmi dns-potrero
	docker rmi dns-merlo

fi

#gunzip $1/dns-latoma.tar.gz
docker load -i $1/dns-latoma.tar.gz
echo "listo latoma"
#gunzip $1/dns-laflorida.tar
docker load -i $1/dns-laflorida.tar.gz
echo "listo laflorida"
#gunzip $1/dns-nogoli.tar
docker load -i $1/dns-nogoli.tar.gz
echo "listo nogoli"
#gunzip $1/dns-desaguadero.tar
docker load -i $1/dns-desaguadero.tar.gz
echo "listo desaguadero"
#gunzip $1/dns-potrero.tar
docker load -i $1/dns-potrero.tar.gz
echo "listo potrero"
#gunzip $1/dns-merlo.tar
docker load -i $1/dns-merlo.tar.gz
echo "listo merlo"


#para saber los nombres de los contenedores que estan corriendo
# docker ps  --format "table {{.Names}}"
