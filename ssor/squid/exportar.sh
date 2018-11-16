#!/bin/bash
if [ -z "$1" ]
then
	echo " ingresar el directorio de exportacion ........ es necesario:"
	docker images  --format "table {{.Repository}} \t   {{  .Size}} "| egrep squid
	exit 
fi
docker save -o $1/squid-latoma.tar squid-latoma 
gzip $1/squid-latoma.tar 
echo "listo latoma"
docker save -o $1/squid-clienteLan2.tar squid-clienteLan2 
gzip $1/squid-clienteLan2.tar 
echo "listo clienteLan2"
docker save -o $1/squid-merlo.tar squid-merlo
gzip $1/squid-merlo.tar
echo "listo merlo"
docker save -o $1/squid-clienteLan1.tar squid-clienteLan1
gzip $1/squid-clienteLan1.tar
echo "listo clienteLan1"
docker save -o $1/squid-potrero.tar squid-potrero
gzip $1/squid-potrero.tar
echo "listo potrero"
docker save -o $1/squid-laflorida.tar squid-laflorida
gzip $1/squid-laflorida.tar
echo "listo laflorida"
docker save -o $1/squid-desaguadero.tar squid-desaguadero
gzip $1/squid-desaguadero.tar
echo "listo desaguadero"
docker save -o $1/squid-nogoli.tar squid-nogoli
gzip $1/squid-nogoli.tar
echo "listo nogoli"



#para saber los nombres de los contenedores que estan corriendo
# docker ps  --format "table {{.Names}}"
