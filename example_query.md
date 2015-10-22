##Query SPARQL di esempio

###Gli eventi che partono in una certa data
```
select ?label ?uri
where {?uri <https://schema.org/startDate> "2015-09-27"^^xsd:date. 
       ?uri rdfs:label ?label}
```

###Tutte le tipologie di eventi
```
select distinct ?type
where {?a rdf:type ?type}
```

###Organizzazioni per numero di eventi
```
select ?org (count(?org) as ?n)
where {?a <https://schema.org/organizer> ?org}
group by ?org
order by desc (?n)
```
