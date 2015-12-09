##Query su Wikidata
Da utilizzare presso: https://query.wikidata.org

### Comuni italiani con codice ISTAT, latitudine e longitudine
```
PREFIX wikibase: <http://wikiba.se/ontology#>
PREFIX wd: <http://www.wikidata.org/entity/>
PREFIX wdt: <http://www.wikidata.org/prop/direct/>

SELECT ?x ?xLabel ?codiceIstat ?coord WHERE {
   ?x wdt:P31 wd:Q747074 .
   ?x wdt:P635 ?codiceIstat .
   ?x wdt:P625 ?coord .
   SERVICE wikibase:label {
       bd:serviceParam wikibase:language "it" .
   }
}
LIMIT 100
```
