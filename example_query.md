##Query SPARQL di esempio

###Gli eventi che partono in una certa data
```
select ?label ?uri
where {?uri <https://schema.org/startDate> "2015-09-27"^^xsd:date. 
       ?uri rdfs:label ?label}
```
