#!/bin/bash
docker stop $(docker ps -aq)

let lineas=`wc -l $1 | cut -d " " -f1`  #obtengo cantidad de lineas
let aux=$lineas
let var=0

while [ $aux -gt 0 ]
do   						#recorro hasta la ultima linea con paso 4
	while [ $var -le 5 ]; do read line
		
		if [ $var -eq 0 ]; then
			nombre=$line
			nombre=`echo $nombre | cut -d "/" -f1`
		else
			break
		fi
		
		((var+=1))
	done < <(tail -$aux $1)
	
	docker commit $nombre squid-$nombre
	docker commit $nombre dhcp-$nombre
	docker commit $nombre dns-$nombre
	docker commit $nombre fire-$nombre
	docker commit $nombre http-$nombre
	docker commit $nombre smb-$nombre
	docker commit $nombre smtp-$nombre
	docker commit $nombre vpn-$nombre
	
	var=0
	aux=$((aux -= 5))	
	
done


docker rm $(docker ps -aq)


#para saber los nombres de los contenedores que estan corriendo
# docker ps  --format "table {{.Names}}"
