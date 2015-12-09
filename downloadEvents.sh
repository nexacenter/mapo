#!/bin/bash

temp="temp.json"
store="appuntamenti.json"
rm $store

while IFS='' read -r line || [[ -n "$line" ]]; do
    wget $line
    sed '1d;$d' "all" >> $store
    #TODO aggiungi virgola alla penultima
    rm "all"
done < "data/lista_url_corta"

#TODO penultima togli virgola
sed -i '1s/^/[\n/' $store
echo ']' >> $store

