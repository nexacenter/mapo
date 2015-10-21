var fs = require('fs');


var cleanTelefono = function (number) {
    return number //TODO fai la pulizia
}

var cleanFields = function (org) {
    //spesso nel campo id vi è un url ma non esiste il campo link
    org.link = org.id;

    if (org.telefono !== undefined)
        org.telefono = cleanTelefono(org.telefono);
    if (org.fax !== undefined)
        org.fax = cleanTelefono(org.fax);

    return org;
}

var removeEmptyFields = function (obj) {
    for (property in obj) {
        if (obj[property] === "")
            delete obj[property];
    }
    return obj;
}

var isEmpty = function (obj) {
    if (Object.keys(obj).length)
        return 0;
    return 1;
}

var alreadyExist = function (obj) {
    for (var i = 0; i < orgArray.length; i++) {
        //per ora controllo solo la concordanza del sito web
        if (obj.link !== undefined && obj.link === orgArray[i].link)
            return orgArray[i].id;
    }
    return 0;
}

var mergeWith = function (index, obj) {
    //se orgArray[index] è vuoto allora riempi con il relativo valore di obj
    for (p in obj) {
        if (orgArray[index][p] === undefined)
            orgArray[index][p] = obj[p];
    }
}

//TODO controlla che non esista già un file con le organizzazioni, se esiste popola l'array
var orgArray = [];
var wholeJson = JSON.parse(fs.readFileSync("data/appuntamenti.json", "utf-8"));

wholeJson.forEach(function (e) {
    var org = cleanFields(e.organizzazione);
    org = removeEmptyFields(org);

    if (!isEmpty(org)) {
        //controllo se questa organizzazione è già presente nel vettore
        if (alreadyExist(org) !== 0) {
            //se è presente cerco di unire eventuali campi extra o discordanti
            mergeWith(alreadyExist(org) - 1, org);
        } else {
            //se non è presente la aggiungo assegnando un nuovo identificativo
            org.id = orgArray.length + 1;
            orgArray.push(org);
        }
    }
});

fs.writeFileSync("data/organizzazioni.json", JSON.stringify(orgArray, null, 4));




