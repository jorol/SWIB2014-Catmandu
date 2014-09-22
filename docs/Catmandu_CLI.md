# Catmandu - *command-line interface* (CLI)

## Daten konvertieren 

    $ catmandu convert MAB to YAML < ./data/journals_mab2.dat
    $ cat ./data/journals_mab2.dat | catmandu convert MAB to YAML 
    $ catmandu convert MAB --type MABxml to JSON < ./data/journals_mab2.xml
    $ catmandu convert MARC to YAML < ./data/camel.mrc
    $ catmandu convert MARC --type XML to JSON < ./data/camel.xml
    $ catmandu convert PICA to YAML < ./data/pica.xml
    $ catmandu convert PICA to JSON < ./data/pica.xml

## Daten "fixen" und konvertieren

    $ catmandu convert MAB --fix "mab_map('331', 'title'); remove_field('record');" to YAML < ./data/journals_mab2.dat
    $ catmandu convert MAB --fix "mab_map('331', 'title'); remove_field('record');" to JSON < ./data/journals_mab2.dat
    $ catmandu convert MAB --fix "mab_map('331', 'title'); remove_field('record');" to CSV < ./data/journals_mab2.dat
    $ catmandu convert MAB --fix "mab_map('331', 'title'); remove_field('record');" to XLS < ./data/journals_mab2.dat
    $ catmandu convert MAB --fix ./fix/mab2.fix to YAML < ./data/journals_mab2.dat
    $ catmandu convert MAB --fix ./fix/mab2.fix to CSV --file mab2.csv --fields identifier,title,language  < ./data/journals_mab2.dat
    $ catmandu convert MAB --fix ./fix/mab2.fix to XLS --file mab2.xls --fields identifier,title,language  < ./data/journals_mab2.dat
    
    # ToDo: mehr 'fix' Beispiele für MARC und PICA+

    # ToDo: Template 
    $ cat test.tt
    [%- FOREACH f IN record %]
    [% _id %] [% f.shift %][% f.shift %][% f.shift %][% f.join(":") %]
    [%- END %]
    $ catmandu convert MARC to Template --template `pwd`/test.tt < records.mrc

## Daten in CouchDB, ElasticSearch & MongoDB importieren

    $ catmandu import MARC --type USMARC to CouchDB --database_name marc --bag marc < ./data/camel.mrc
    $ catmandu import MAB --fix ./fix/zdb_bibliographic.fix to MongoDB --database_name mab --bag mab < ./data/journals_mab2.dat
    $ catmandu import MAB --fix ./fix/zdb_bibliographic.fix to ElasticSearch --index_name mab --bag mab < ./data/journals_mab2.dat

## Daten aus CouchDB, ElasticSearch & MongoDB exportieren

    $ catmandu export CouchDB --database_name marc --bag marc to JSON
    $ catmandu export MongoDB --database_name mab --bag mab to JSON
    $ catmandu export ElasticSearch --index_name mab --bag mab to JSON

## Daten zwischen CouchDB, ElasticSearch & MongoDB migrieren

    $ catmandu move MongoDB --database_name mab --bag mab to ElasticSearch --index_name mab --bag mab
    $ catmandu move MongoDB --database_name mab --bag mab to CouchDB --database_name mab --bag mab
    $ catmandu move CouchDB --database_name mab --bag mab to MongoDB --database_name mab --bag mab
    $ catmandu move MongoDB --database_name mab --bag mab --query "{\"dcterms.spatial\": \"XA-DE\"}" to ElasticSearch --index_name moved --bag moved
    $ catmandu move ElasticSearch --index_name moved --bag moved --query "dc.identifier:\"47918-4\"" to ElasticSearch --index_name selected --bag selected

## Anzahl Datensätze ermitteln

    $ catmandu count CouchDB --database-name mab --bag mab
    $ catmandu count MongoDB --database-name mab --bag mab
    $ catmandu count MongoDB --database-name mab --bag mab --query "{\"dc.publisher\": \"Heise\"}"
    $ catmandu count ElasticSearch --index-name mab --bag mab
    $ catmandu count ElasticSearch --index-name mab --bag mab --query 'dc.publisher:"Heise"'

## Daten aus CouchDB, ElasticSearch & MongoDB löschen

    $ catmandu delete CouchDB --database_name mab --bag mab  
    $ catmandu delete MongoDB --database_name mab --bag mab  
    $ catmandu delete ElasticSearch --index_name mab --bag mab
    $ catmandu delete MongoDB --database_name mab --bag mab --q '{"_id":"1262750"}'
    $ catmandu delete ElasticSearch --index_name mab --bag mab --q '_id:"1262750"'

## catmandu data

    $ catmandu data --from-store MongoDB --from-database_name mab --from-bag mab --query "{\"dc.identifier\": \"47918-4\"}"
    $ catmandu data --from-store ElasticSearch --from-index_name mab --from-bag mab --query "dc.identifier:\"47918-4\""
    $ catmandu data --from-store ElasticSearch --from-index_name mab --from-bag mab --cql-query "identifier exact 47918-4"
    $ catmandu data --from-store ElasticSearch --from-index_name mab --from-bag mab --cql-query "publisher exact Heise"
    $ catmandu data --from-store ElasticSearch --from-index_name mab --from-bag mab --cql-query "issued > 2009" --into-exporter YAML
    $ catmandu data --from-store ElasticSearch --from-index_name mab --from-bag mab --cql-query "issued > 2009" --into-exporter CSV --fix 'retain_field("_id")'
    # ToDo: Export mit fix

## *config*-Datei

