#!/bin/bash

echo "Start at "$(date +%c)

#scarica i json dalle API
#echo "> Downloading"
#TODO

#lavora sui json scaricati
echo "> Working on events JSON"
nodejs adjustEvents.js

#converte caratteri unicode in HTML
echo "> Converting unicode chars"
cat data/eventi.json | uni2ascii -a H -q > eventi-temp.json
rm data/eventi.json
mv eventi-temp.json data/eventi.json

#lancia il triplificatore
#echo "> Triplifing"
#TODO

#carica gli rdf sull'endpoint
#echo "> Loading data to the endpoint"
#TODO

echo "Finished at "$(date +%c)
