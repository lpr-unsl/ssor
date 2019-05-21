#!/bin/bash

for i in router cliente-cli cliente servidor ;
do
	cd $i
	docker build -t $i:3.0 .
done

