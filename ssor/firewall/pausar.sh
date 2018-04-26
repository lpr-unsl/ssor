
docker stop $(docker ps -aq)


docker commit latoma fire-latoma
docker commit merlo fire-merlo
docker commit potrero fire-potrero
docker commit laflorida fire-laflorida
docker commit desaguadero fire-desaguadero
docker commit nogoli fire-nogoli


docker rm $(docker ps -aq)

#para saber los nombres de los contenedores que estan corriendo
# docker ps  --format "table {{.Names}}"
