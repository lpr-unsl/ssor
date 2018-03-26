
docker stop $(docker ps -aq)


docker commit latoma dhcp-latoma
docker commit clienteLan2 dhcp-clientelandos
docker commit potrero dhcp-potrero
#docker commit laflorida dhcp-laflorida
docker commit merlo dhcp-merlo
docker commit clienteLan1 dhcp-clientelanuno
docker commit sanfelipe dhcp-sanfelipe


docker rm $(docker ps -aq)

#para saber los nombres de los contenedores que estan corriendo
# docker ps  --format "table {{.Names}}"
