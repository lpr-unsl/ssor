
docker stop $(docker ps -aq)


docker commit latoma smb-latoma
docker commit potrero smb-potrero



docker rm $(docker ps -aq)

#para saber los nombres de los contenedores que estan corriendo
# docker ps  --format "table {{.Names}}"
