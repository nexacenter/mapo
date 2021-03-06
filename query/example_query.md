##Query SPARQL di esempio

###Eventi che partono in una certa data
```
select ?label ?uri
where {?uri <https://schema.org/startDate> "2015-09-27"^^xsd:date. 
       ?uri rdfs:label ?label}
```

###Tutte le tipologie di eventi per numero di occorrenze
```
SELECT distinct ?t (count(?t) as ?c)
WHERE {
    ?a <http://www.w3.org/1999/02/22-rdf-syntax-ns#type> ?t.
}
GROUP BY (?t)
ORDER BY DESC (?c)
```

###Organizzazioni per numero di eventi
```
select ?org (count(?org) as ?n)
where {?a <https://schema.org/organizer> ?org}
group by ?org
order by desc (?n)
```

###Eventi che si svolgono in comuni sopra i 600m
```
select distinct ?evento ?comune ?elev
with {
    select distinct ?url where {?a <http://mapo.nexacenter.org/id/eventi/hasUrlComune> ?url .}
} as %url
where {
    include %url
    bind(uri(?url)as ?uri)
    service <http://dbpedia.org/sparql> {
        ?comune foaf:homepage ?uri .
        ?comune <http://dbpedia.org/property/elevationM> ?elev
    }
    ?evento <http://mapo.nexacenter.org/id/eventi/hasUrlComune> ?url
    FILTER (?elev >= 600)
}
```

###Eventi che si trovano all'interno di un rettangolo di coordinate
```
SELECT ?comune ?lat ?long ?name ?e
WHERE {
  ?x rdfs:label ?comune .
  ?x <https://schema.org/latitude> ?lat .
  ?x <https://schema.org/longitude> ?long .
  ?e rdfs:label ?name .
  ?e <http://dbpedia.org/ontology/city> ?x .
  FILTER ( ?long > MIN_LONG && ?long < MAX_LONG && ?lat > MIN_LAT && ?lat < MAX_LAT)
}
LIMIT 100
```

###Eventi che si trovano all'interno di un raggio RADIUS di centro (YOUR_LAT,YOUR_LONG)
```
SELECT ?comune ?lat ?long ?name ?e
WHERE {
  ?x rdfs:label ?comune .
  ?x <https://schema.org/latitude> ?lat .
  ?x <https://schema.org/longitude> ?long .
  ?e rdfs:label ?name .
  ?e <http://dbpedia.org/ontology/city> ?x .
  FILTER ( ?long > YOUR_LONG - RADIUS && ?long < YOUR_LONG + RADIUS && ?lat > YOUR_LAT - RADIUS && ?lat < YOUR_LAT + RADIUS)
}
LIMIT 100

```
