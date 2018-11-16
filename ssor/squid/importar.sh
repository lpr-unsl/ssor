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


imagenes=`docker images| egrep squid | wc -l`
if [ $imagenes -gt 0 ]
then

	docker rmi squid-latoma 
	docker rmi squid-clienteLan2 
	docker rmi squid-merlo
	docker rmi squid-clienteLan1
	docker rmi squid-potrero
	docker rmi squid-laflorida
	docker rmi squid-desaguadero
	docker rmi squid-nogoli

fi

#gunzip $1/squid-latoma.tar.gz
docker load -i $1/squid-latoma.tar.gz
echo "listo latoma"
#gunzip $1/squid-clienteLan2.tar
docker load -i $1/squid-clienteLan2.tar.gz
echo "listo clienteLan2"
#gunzip $1/squid-merlo.tar
docker load -i $1/squid-merlo.tar.gz
echo "listo merlo"
#gunzip $1/squid-clienteLan1.tar
docker load -i $1/squid-clienteLan1.tar.gz
echo "listo clienteLan1"
#gunzip $1/squid-potrero.tar
docker load -i $1/squid-potrero.tar.gz
echo "listo potrero"
#gunzip $1/squid-laflorida.tar
docker load -i $1/squid-laflorida.tar.gz
echo "listo laflorida"
#gunzip $1/squid-desaguadero.tar
docker load -i $1/squid-desaguadero.tar.gz
echo "listo desaguadero"
#gunzip $1/squid-nogoli.tar
docker load -i $1/squid-nogoli.tar.gz
echo "listo nogoli"



#para saber los nombres de los contenedores que estan corriendo
# docker ps  --format "table {{.Names}}"
