
docker stop $(docker ps -aq)


docker commit latoma squid-latoma
docker commit merlo squid-merlo
docker commit potrero squid-potrero
docker commit laflorida squid-laflorida
docker commit desaguadero squid-desaguadero
docker commit nogoli squid-nogoli


docker rm $(docker ps -aq)

#para saber los nombres de los contenedores que estan corriendo
# docker ps  --format "table {{.Names}}"
