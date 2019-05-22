#!/bin/bash
version=`cat ../version.txt`
clear
echo ""
echo "          - CONTRUCCION NUEVA VERSION DE IMAGENES PARA LPR -
              SOLO EJECUTARLO SI SABE QUE ESTA HACIENDO 
         SOLO EJECUTARLO SI ES LA PRIMERA VEZ QUE VA A USARLAS
         VERSION: $version         

         Requisitos: un disco (usb o particion de al menos 4Gb)
	             conexion a internet
         SE PERDERAN TODOS LOS DATOS DEL MISMO !!!!!"
echo ""
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
for i in router cliente-cli cliente servidor ;
do
	cd $i
	docker build -t $i:$version .
	cd ..
done

echo ""
echo "Ahora a trabajar !!! los practicos estan en el directorio ssor "
