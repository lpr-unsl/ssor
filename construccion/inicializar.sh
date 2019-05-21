#!/bin/bash
clear
echo ""
echo "          - CONTRUCCION NUEVA VERSION DE IMAGENES PARA LPR -
              SOLO EJECUTARLO SI SABE QUE ESTA HACIENDO "
echo ""
echo -n "quiere continuar?(S/n) "
read continua

if [ $continua != "S" ]
then
        exit
fi

version=`cat ../version.txt`
echo "$version"
for i in router cliente-cli cliente servidor ;
do
	cd $i
	docker build -t $i:$version .
	cd ..
done

