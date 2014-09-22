# Catmandu - Importing, transforming, storing and indexing data should be easy

SWIB2014 1 - 3 December 2014 Bonn, Germany

Johann Rolschewski / Jakob Voß

Staatsbibliothek zu Berlin, Germany / Verbundzentrale des GBV (VZG), Germany

## LibreCat

... is an open collaboration of the three university libraries of Lund, Gent and Bielefeld

## Catmandu

... provide the open source set of programming components to build up digital libraries and research services 

... import data from various sources

... map the fields to a common data model

... store in database or search engine

... export data in various formats

## ETL 

Extract, Transform, Load 

## Import

AlephX BibTeX MAB2 MARC PICA
Atom CSV JSON RDF YAML XLS

## Export

AlephX BibTeX MAB2 MARC PICA
Atom CSV JSON RDF YAML XLS

## API

getJSON

OAI

SRU

## Stores

DBI

Elascticsearch

MongoDB

## CLI

```terminal
catmandu <command> [-DIL] [long options...]
    -D --debug          
    -L --load_path      
    -I --lib_path       

Available commands:

       commands: list the application's commands
           help: display a command's help screen

         config: export the Catmandu config
        convert: convert objects
          count: count the number of objects in a store
           data: store, index, search, import, export or convert objects
         delete: delete objects from a store
         export: export objects from a store
  exporter_info: list installed Catmandu exporters
       fix_info: list installed Catmandu fixes
         import: import objects into a store
  importer_info: list installed Catmandu importers
    module_info: list installed perl modules in a given namespace
           move: move objects to another store
           repl: interactive shell for Catmandu
     store_info: list installed Catmandu stores
```

## CLI - convert()

```terminal
catmandu convert [-?hLv] [long options...]

examples:

cat books.json | catmandu convert JSON to CSV --fields id,title

options:

        -? -h --help        this usage screen
        -L --load_path
        -v --verbose
```

## CLI - convert()

```terminal
$ cat ./shared/journals_mab2.dat | catmandu convert MAB to JSON

$ catmandu convert MAB to JSON < ./shared/journals_mab2.dat

$ catmandu convert MAB --type MABxml to JSON < ./shared/journals_mab2.xml
```

## CLI - convert()

```terminal
$ catmandu convert MARC to JSON < ./shared/camel.mrc

$ catmandu convert MARC --type XML to JSON < ./shared/camel.xml
```

## CLI - convert()

```terminal
$ catmandu convert PICA to YAML < ./shared/pica.xml

$ catmandu convert PICA to JSON < ./shared/pica.xml
```

## CLI - convert()

```terminal
$ catmandu convert CSV to JSON < ./shared/journals.csv

$ catmandu convert YAML to JSON < ./shared/journals.yml
```

## CLI - convert()

```terminal
$ catmandu convert MAB --fix ./fix/mab2.fix to CSV --file mab2.csv --fields identifier,title,language < ./shared/journals_mab2.dat

$ catmandu convert MAB --fix ./fix/mab2.fix to XLS --file mab2.xls --fields identifier,title,language < ./shared/journals_mab2.dat
```

## CLI - convert()

```terminal
$ cat ./template/test.tt
[%- FOREACH f IN record %]
[% _id %] [% f.shift %][% f.shift %][% f.shift %][% f.join(":") %]
[%- END %]

$ catmandu convert MARC to Template --template D:\Workspace\Catmandu-Workshop2013\template\test.tt < ./shared/camel.mrc

$ cat ./template/marc.tt
[% _id %] [% authors.0 %]: [% title %]

$ catmandu convert MARC --fix ./fix/marc.fix to Template --template D:\Workspace\Catmandu-Workshop2013\template\marc.tt < ./shared/camel.mrc
```

## CLI - import()

```terminal
catmandu import [-?hLv] [long options...]

examples:

catmandu import YAML --file books.yml to MongoDB 
    --database_name items --bag book

options:

        -? -h --help        this usage screen
        -L --load_path
        -v --verbose
```

## CLI - import()

```terminal
$ catmandu import MARC --type USMARC to MongoDBDB --database_name marc --bag marc < ./shared/camel.mrc

$ catmandu import MAB --fix ./shared/mab2.fix to MongoDB --database_name mab --bag mab  < ./shared/journals_mab2.dat

$ catmandu import MAB --fix ./fix/mab2.fix to ElasticSearch --index_name mab --bag mab < ./shared/journals_mab2.dat
```

## CLI - export()

```terminal
catmandu export [-?hLqv] [long options...]

examples:

catmandu export MongoDB --database_name items --bag book to YAML

options:

        -? -h --help        this usage screen
        -L --load_path
        -v --verbose
        -q --query
        --limit
```

## CLI - export()

```terminal
$ catmandu export MongoDB --database_name mab --bag mab to JSON

$ catmandu export ElasticSearch --index_name mab --bag mab to JSON
```

## CLI - count()

```terminal
catmandu count [-?hLq] [long options...]

examples:

catmandu count ElasticSearch --index_name shop --bag products 
    --query 'brand:Acme'

options:

        -? -h --help        this usage screen
        -L --load_path
        -q --query
```

## CLI - count()

```terminal
$ catmandu count CouchDB --database_name marc --bag marc

$ catmandu count MongoDB --database_name mab --bag mab

$ catmandu count MongoDB --database_name mab --bag mab --query "{\"dc.publisher\": \"Heise\"}"

$ catmandu count ElasticSearch --index_name mab --bag mab

$ catmandu count ElasticSearch --index_name mab --bag mab --query 'dc.publisher:"Heise"'
```

## CLI - delete()

```terminal
catmandu delete [-?hLq] [long options...]

examples:

catmandu delete ElasticSearch --index_name items 
    --bag book -q 'title:"Programming Perl"'

options:

        -? -h --help        this usage screen
        -L --load_path
        -q --query
```

## CLI - delete()

```terminal
$ catmandu delete CouchDB --database_name marc --bag marc

$ catmandu delete MongoDB --database_name mab --bag mab

$ catmandu delete ElasticSearch --index_name mab --bag mab

$ catmandu delete MongoDB --database_name mab --bag mab --q '{"_id":"1262750"}'

$ catmandu delete ElasticSearch --index_name mab --bag mab --q '_id:"1262750"'
```

## CLI - move()

```terminal
catmandu move [-?hLqv] [long options...]

examples:

catmandu move MongoDB --database_name items --bag book 
    to ElasticSearch --index_name items --bag book

options:

        -? -h --help        this usage screen
        -L --load_path
        -v --verbose
        -q --query
        --limit
```

## CLI - move()

```terminal
$ catmandu move MongoDB --database_name mab --bag mab to ElasticSearch --index_name mab --bag mab

$ catmandu move MongoDB --database_name mab --bag mab to CouchDB --database_name mab --bag mab

$ catmandu move MongoDB --database_name mab --bag mab --query "{\"dcterms.spatial\": \"XA-DE\"}" to ElasticSearch --index_name moved --bag moved

$ catmandu move ElasticSearch --index_name moved --bag moved --query "dc.identifier:\"47918-4\"" to ElasticSearch --index_name selected --bag selected
```

## CLI - data()

```terminal
catmandu data [-?hLqv] [long options...]

        -? -h --help         this usage screen
        -L --load_path
        --from-store
        --from-importer
        --from-bag
        --count
        --into-exporter
        --into-store
        --into-bag
        --start
        --limit
        --total
        -q --cql-query
        --query
        --fix                fix expression(s) or fix file(s)
        --replace
        -v --verbose
```

## CLI - data()

```terminal
$ catmandu data --from-store MongoDB --from-database_name mab --from-bag mab --query "{\"dc.identifier\": \"47918-4\"}"

$ catmandu data --from-store ElasticSearch --from-index_name mab --from-bag mab --query "dc.identifier:\"47918-4\""

$ catmandu data --from-store ElasticSearch --from-index_name mab --from-bag mab --cql-query "publisher exact Heise"

$ catmandu data --from-store ElasticSearch --from-index_name mab --from-bag mab --cql-query "issued > 2009" --into-exporter YAML

$ catmandu data --from-store ElasticSearch --from-index_name mab --from-bag mab --cql-query "issued > 2009" --into-exporter CSV --fix 'retain_field("_id")'
```

## CLI - APIs

```terminal
$ catmandu convert OAI --url http://pub.uni-bielefeld.de/oai to JSON

$ catmandu convert SRU --base http://sru.gbv.de/gvk --recordSchema picaxml --parser picaxml --query "pica.iss=0939-4362" to JSON    

$ http://search.cpan.org/~voj/Catmandu-Importer-getJSON-0.1.1/lib/Catmandu/Importer/getJSON.pm
```

## Catmandu::Fix

... easy data manipulation by non programmers

... small Perl DSL language

## Catmandu::Fix - Path

```perl
$append   - Add a new item at the end of an array
$prepend  - Add a new item at the start of an array
$first    - Syntactic sugar for index '0' (the head of the array)
$last     - Syntactic sugar for index '-1' (the tail of the array)
```

## Catmandu::Fix::marc_map

```perl
    marc_map('008_/35-38','language');
    marc_map('100','authors.$append');
    marc_map('245[10]a','title');
    marc_map('500a','publisher');
    marc_map('650a','subject', -join => '; ');
    remove_field('record');
```

## Catmandu::Fix::mab_map

```perl
mab_map('001','identifier');
mab_map('002[a]','date');
mab_map('037[b]','language');
mab_map('050[ ]','format');
mab_map('052[ ]_/0-0','type');
mab_map('331[ ]','title');
mab_map('406jk','coverage.$append', -join => ' - ');
mab_map('700[bc]','subject.$append');
remove_field('record');
```

## Catmandu::Fix::pica_map

```perl
pica_map('001A0','date');
pica_map('010@a','language');
pica_map('009Qa','primaryTopicOf.$append');
pica_map('027A[01]a','furtherTitle');
remove_field('record');
```

## Catmandu::Fix

```perl
# Add a new field
add_field('name','Smith');  # {name => 'Smith'}

# Change a value
set_field('name','Doe');  # {name => 'Doe'}

# Append to a value
append('name', ', John');  # {name => 'Doe, John'}

# Prepend to a value
prepend('name', ', Mr. ');  # {name => 'Mr. Doe, John'}

# Extract a substring from the value
substring('name',0,3);  # {name => 'Mr.'}
```

## Catmandu::Fix

```perl
# {format => 'print'}                    
# Copy field
copy_field('format','dc.format');

# Delete field
remove_field('format');

# Move field
move_field('format','dc.format');

# Delete every field except named field
retain_field('dc.format')
```

## Catmandu::Fix

```perl
# {format => 'marc'}
# Capitalize a value
capitalize('format');  # {format => 'Marc'}

# Uppercase a value
upcase('format');  # {format => 'MARC'}

# Downcase a value
downcase('format');  # {format => 'marc'}   
```

## Catmandu::Fix

```perl
# {foo => '   abc   '}
# Trim whitespace
trim('foo');  # {foo => 'abc'}
trim('foo', 'whitespace');  # {foo => 'abc'};

# trim non-word characters
# {foo => '   abc  / : .'}
trim('foo', 'nonword');  # {foo => 'abc'};
```

## Catmandu::Fix

```perl
# {ddc => ['000', '004', '600']}
# Join elements of a field
join_field('ddc',',');  # {ddc => '001,004,600'}

# Split string to array
split_field('ddc', ',')  # {ddc => ['000', '004', '600']}

# Count elements in array
count('ddc');  # 3
```

## Catmandu::Fix

```perl
# {format => 'MAB'}
# Search and replace using regex expressions
# Replace characters in string
replace_all('format', 'a', 'x')  # {format => 'MxB'}    

# {id => ['123-4', '567-X']}
# Search and replace in array
replace_all('identifier.*', '-[0-9xX]$', '') # {id => ['123', '567']}
```

## Catmandu::Fix

```perl
# lookup value of 'ddc' in dict.csv and 
# replace the value or set it to '000'
lookup('ddc', 'dict.csv', -default=>'000');

# lookup value of 'ddc' in dict.csv and 
# replace the value or delete nothing found
lookup('ddc', 'dict.csv', -delete=>'1');   

# lookup value of 'ddc' in MongoDB and
# replace it with the data found
lookup_in_store('ddc', 'MongoDB', -database_name => 'lookups'); 
lookup_in_store('ddc', 'MongoDB', -delete => 1);
```

## Catmandu::Fix

```perl
# set value of field 'ddc' to 'Informatik' 
# if field 'ddc' has the value '004'
if_any_match('ddc', '004');
  set_field('ddc', 'Informatik');
end();
# inverted
unless_any_match('ddc', '000');
  lookup('ddc', 'dict.csv',  -delete=>'1');
end();
# lookup 'ddc' value in dict.csv
if_exists('ddc');
  lookup('ddc', 'dict.csv',  -delete=>'1');
end();
# inverted
unless_exists('ddc');
  add_field('ddc', '000');
end();
```

## Catmandu::Fix

```perl
# Collapse deep nested hash to a flat hash
collapse();

# Expand flat hash to deep nested hash
expand();               

# Clone the perl hash and work on the clone
clone();
```

## Catmandu::Fix

```perl
# Use an external program that can read JSON 
# from stdin and write JSON to stdout
cmd("java MyClass");
```

## config

```yaml
    ---
    store:
      mo:
       package: MongoDB
       options:
        database_name: bibliographic
        bag: marc

```

## Catmandu::Importer
    
* Parser
* Importer
* Fix

## Catmandu::Importer
    
    D:\WORKSPACE\DIST\CATMANDU-PICA
    │   ...
    │
    ├───lib
    │   └───Catmandu
    │       │   PICA.pm
    │       │
    │       ├───Fix
    │       │       pica_map.pm
    │       │
    │       └───Importer
    │               PICA.pm
    │
    └───t
            ...

## Catmandu::Fix

    package Catmandu::Fix::normalize_title;

    use Moo;

    sub fix {
        my ($self, $record) = @_;
        if ( $record->{dc}->{title} ) {
            $record->{dc}->{title} =~ s/[\x{98},\x{9c}]//g;
        }
        $record; 
    }

    1;


