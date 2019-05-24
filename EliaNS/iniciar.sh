#!/bin/bash


nombre=""
tipo=""
interfaces=""
rutas=""
basura=""
arrayInt=()
arrayRutas=()

function Docker(){

	puente=`brctl show | egrep lan1`
	if [ -z "$puente" ]
	then
		brctl addbr lan1
		brctl addbr lan2
		brctl addbr lan3
		brctl addbr ppp1
		brctl addbr ppp2
		brctl addbr man1
	fi

	ip link set dev lan1 up
	ip link set dev lan2 up
	ip link set dev lan3 up
	ip link set dev ppp1 up
	ip link set dev ppp2 up
	ip link set dev man1 up
	
	montaje=`df -h | egrep docker`
	if [ -z "$montaje" ]
	then
	        echo -n " falta montar la particion con las imagenes, especifique el dispositivo: "
		read dispositivo
		service docker stop
		mount $dispositivo /var/lib/docker
		service docker start
	fi
	
	contenedores=`docker ps -aq|wc -l`
	
	if [ $contenedores -gt 0 ]
	then
		docker stop $(docker ps -aq)
		docker rm $(docker ps -aq)
	fi
	
	imagenes=`docker images| egrep http | wc -l`
	if [ $imagenes -gt 0 ]
	then
		docker rmi http-latoma
		docker rmi http-merlo
		docker rmi http-potrero
		docker rmi http-laflorida
		docker rmi http-desaguadero
		docker rmi http-nogoli
		docker rmi http-carrizal
		docker rmi http-laslenias
	fi
	
}

function Iniciar(){
	temp=$2	
	size=${#temp}
	
	case "$temp" in 
		servidor)
			imagen="--privileged servidor:1.6";;
		cliente)
			imagen="--env="DISPLAY" --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" cliente:1.6";;
		cliente-cli)
			imagen="cliente-cli:1.6";;
		router)
			imagen="router:1.6";;
		*) echo "error"; exit;;
	esac

	docker run --detach --hostname $1 -it --name $1 --cap-add NET_ADMIN $imagen bash
	
#	echo docker exec -t "$1" ip ro del default
	docker exec -t "$1" ip ro del default


#ASIGNAR INTERFACES CON BUCLE
	
	let cantInt=${#arrayInt[*]}
	temp=$(( $cantInt + $cantInt - 2 ))

	for (( z=0 ; z<=$temp ; z+=5 )); do
		nomInt="${arrayInt[z]}"
		dir="${arrayInt[z+1]}"
		pipework $nomInt -i $nomInt $1 $dir
	done				
	temp=0


#ASIGNAR RUTAS CON BUCLE
	
	cantRutas=${#arrayRutas[*]}
	for (( z=0 ; z <= $cantRutas ; z+=4 )); do
	       	dired=${arrayRutas[z]}
      		gateway=${arrayRutas[z+2]}
		disp=${arrayRutas[z+3]}
		
		if [ $cantInt -eq 2 ];then
#			echo docker  exec -t $1 ip ro add default via $gateway
			docker exec -t $1 ip ro add default via $gateway
			break 1
		else
#			echo docker exec -t $1 ip ro add $dired via $gateway
			docker exec -t $1 ip ro add $dired via $gateway
		fi
	done
	

##ARRANCAR TERMINAL
	xterm -T "$1" -fa monaco -fs 11 -e "docker attach $1" &
}

function DatosFinales(){
	nom=$1
	tip=$2

	cant=`echo -n $3 | wc -c`  #obtengo contidad de caracteres
	i=0
	for var2 in $3
	do
		arrayInt[i]=`echo $var2 | cut -d "," -f1` #agrego elemento al array eliminando la coma
		i=$((i+1))

	done

	cant=`echo -n $rutas | wc -c`  #obtengo contidad de caracteres
	i=0
	for var2 in $4
	do
		arrayRutas[i]=`echo $var2 | cut -d "," -f1` #agrego elemento al array eliminando la coma
	        i=$((i+1))
	done



	cant=${#arrayInt[*]}  #cantidad de elementos del array
	for(( x = 0 ; x <= $cant ; x += 5 )); do
	        k=`expr $x + 2`
	        if [ "${arrayInt[k]}" == "255.255.255.0" ]; then
	               arrayInt[k-1]=${arrayInt[k-1]}"/24"
	        elif [ "${arrayInt[k]}" == "255.255.254.0" ]; then
	               arrayInt[k-1]=${arrayInt[k-1]}"/23"
	        elif [ "${arrayInt[k]}" == "255.255.254.240" ]; then
	               arrayInt[k-1]=${arrayInt[k-1]}"/28"
	        elif [ "${arrayInt[k]}" == "255.255.255.240" ]; then
	               arrayInt[k-1]=${arrayInt[k-1]}"/28"
	        elif [ "${arrayInt[k]}" == "255.255.255.252" ]; then
 	               arrayInt[k-1]=${arrayInt[k-1]}"/30"
	        fi
	done

	for(( x = 0 ; x <= $cant ; x += 5 )); do
	        k=`expr $x + 2`
		unset arrayInt[k] #elimino elemento
		unset arrayInt[k+1]
		unset arrayInt[k+2]
	done

	cant=${#arrayRutas[*]}  #cantidad de elementos del array
	for(( x = 0 ; x <= $cant ; x += 4 )); do
	        k=`expr $x + 1`
	        if [ "${arrayRutas[k]}" == "255.255.255.0" ]; then
	                arrayRutas[k-1]=${arrayRutas[k-1]}"/24"
	        elif [ "${arrayRutas[k]}" == "255.255.254.0" ]; then
	                arrayRutas[k-1]=${arrayRutas[k-1]}"/23"
	        elif [ "${arrayRutas[k]}" == "255.255.254.240" ]; then
	                arrayRutas[k-1]=${arrayRutas[k-1]}"/28"
		elif [ "${arrayRutas[k]}" == "255.255.255.240" ]; then
		        arrayRutas[k-1]=${arrayRutas[k-1]}"/28"
		elif [ "${arrayRutas[k]}" == "255.255.255.252" ]; then
		        arrayRutas[k-1]=${arrayRutas[k-1]}"/30"
		fi
	done

	for(( x = 0 ; x <= $cant ; x += 4 )); do
	        k=`expr $x + 1`
	        unset arrayRutas[k] #elimino elemento
	done
	
	echo "NOMBRE: "$nom
	echo "TIPO: "$tip
	echo "INTERFACES: " ${arrayInt[@]}
	echo "RUTAS: " ${arrayRutas[@]}
	echo ""
	Iniciar $nom $tip
	echo "----------------------------------------------------------------------------"	
	arrayInt=()
	arrayRutas=()
}

let var=0
let lineas=`wc -l $1 | cut -d " " -f1`  #obtengo cantidad de lineas
let aux=$lineas

Docker	#llamo a funcion Docker

echo "----------------------------------------------------------------------------"
echo "                              CONTENEDORES                                  "
echo "----------------------------------------------------------------------------"


while [ $aux -gt 0 ]
do   						#recorro hasta la ultima linea con paso 4
	while [ $var -le 5 ]; do read line
		if [ $var -eq 0 ]; then
			nombre=$line
			tipo=`echo $nombre | cut -d "/" -f2`
			nombre=`echo $nombre | cut -d "/" -f1`
		elif [ $var -eq 1 ]; then
			interfaces=${line#"["}		#elimino primer corchete
			interfaces=`echo $interfaces | cut -d "]" -f1`		#elimino ultimo corchete	
		elif [ $var -eq 2 ]; then
			rutas=${line#"["}
			rutas=`echo $rutas | cut -d "]" -f1`
			p1=`echo $nombre`
			p2=`echo $tipo`
			p3=`echo $interfaces`
			p4=`echo $rutas`
			#echo ""
			DatosFinales "$p1" "$p2" "$p3" "$p4"

		else
			basura=$line
		fi
		((var+=1))
	done < <(tail -$aux $1)

	var=0
	aux=$((aux -= 5))	

done

