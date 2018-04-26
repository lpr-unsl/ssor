
docker stop $(docker ps -aq)


docker commit latoma vpn-latoma
docker commit merlo vpn-merlo
docker commit potrero vpn-potrero
docker commit laflorida vpn-laflorida
docker commit desaguadero vpn-desaguadero
docker commit carrizal vpn-carrizal
docker commit laslenias vpn-laslenias


docker rm $(docker ps -aq)

#para saber los nombres de los contenedores que estan corriendo
# docker ps  --format "table {{.Names}}"
