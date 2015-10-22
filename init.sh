#!/bin/bash

echo "Start at "$(date +%c)

#scarica i json dalle API
#echo "> Downloading"
#TODO

#lavora sui json scaricati
echo "> Working on events JSON"
node adjustEvents.js

#converte caratteri unicode in HTML
echo "> Converting unicode chars"
cat data/eventi.json | uni2ascii -a H -q > eventi-temp.json
rm data/eventi.json
mv eventi-temp.json data/eventi.json

#lancia il triplificatore
echo "> Triplifing"
java -jar triplifier-0.1.jar data/eventi.json data/model-eventi.json id
java -jar triplifier-0.1.jar data/organizzazioni.json data/model-organizzazioni.json id

#carica gli rdf sull'endpoint
echo "> Loading data to the endpoint"
curl -XPOST --data-binary update="LOAD <file:///var/www/mapo.nexacenter.org/mapo/output/eventi.nt>" http://localhost:9999/bigdata/namespace/mapo/sparql
curl -XPOST --data-binary update="LOAD <file:///var/www/mapo.nexacenter.org/mapo/output/organizzazioni.nt>" http://localhost:9999/bigdata/namespace/mapo/sparql

echo "Finished at "$(date +%c)
