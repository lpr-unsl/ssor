#!/bin/bash
clear
version=`cat ./version.txt`

echo ""
echo "          - PROCEDIMIENTO PARA INICIALIZAR MAQUINAS VIRTUALES -
         SOLO EJECUTARLO SI ES LA PRIMERA VEZ QUE VA A USARLAS
         VERSION $version         

         Requisitos: un disco (usb o particion de al menos 4Gb)
         SE PERDERAN TODOS LOS DATOS DEL MISMO !!!!!"
echo ""
echo -n "quiere continuar?(S/n) "
read continua

if [ $continua != "S" ]
then
	exit
fi
echo ""
echo -n "especifique el nombre del dispositivo a utilizar: "
read dispositivo

montaje=`df -h | egrep $dispositivo`
if [ -n "$montaje" ]
then
      	umount $dispositivo
fi

mkfs.ext4 $dispositivo
service docker stop
mount $dispositivo /var/lib/docker
service docker start

for nombre in servidor cliente cliente-cli router
do
docker pull sistemasoperativostur/netoslab-$nombre:$version
echo "listo $nombre"
docker tag sistemasoperativostur/netoslab-$nombre:$version $nombre:$version
done
echo ""
echo "Ahora a trabajar !!! los practicos estan en el directorio ssor "
