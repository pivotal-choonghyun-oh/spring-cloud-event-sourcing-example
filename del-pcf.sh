#!/bin/sh

apps='account-service catalog-service config-service discovery-service edge-service inventory-service online-store-web order-service shopping-cart-service user-service zipkin'


for x in $apps
do
	cf d $x -f -r 
done
