% Processing RDF with Catmandu

# Setup

To installl Catmandu RDF support on your own machine:

```terminal
$ cpanm --sudo install Catmandu::RDF
```

Unfortunately Catmandu-RDF at the virtual machine is broken. Fix with:

```terminal
$ cpanm --sudo List::Util
```

# Convert RDF

```terminal
$ catmandu convert RDF --file ./shared/zdb_resources.rdf to YAML
$ catmandu convert RDF --url http://d-nb.info/1001703464 to YAML
```

## Introduction

* RDF data is graphs
* Catmandu items are records

*RDF graph <-> records/items* (noSPARQL)

## Introduction: expressing RDF data

* Many serialization forms (RDF/XML, JSON-LD, Turtle...)
* Multiple forms of URI abbreviation

## Another RDF encoding Form (aREF)

<http://gbv.github.io/aREF/>

```yaml
http://dx.doi.org/10.2474/trol.7.147:
  dct_title:
  - Frictional Coefficient under Banana Skin@
  dct_date:
  - 2012^xs_gYear
  dct_isPartOf:
  - <http://id.crossref.org/issn/1881-2198>
```

## Multiple URI abbreviations

  dc:title  = http://purl.org/dc/elements/1.1/title
  dce:title = http://purl.org/dc/elements/1.1/title
  dct:title = http://purl.org/dc/terms/title
  dcq:title = http://purl.org/dc/terms/title
  dcq:title = http://purl.org/dc/qualifiers/1.0/title
  ...

Solution: tack namespace prefixes

## tack namespace prefixes

* Popular namespace prefixes from <http://prefix.cc>
* In Perl module RDF:NS: <https://metacpan.org/release/RDF-NS>
* tack a date, e.g. 20131205

$ catmandu convert RDF --file --ns 20140919 ./shared/zdb_resources.rdf to YAML
$ catmandu convert RDF --file --ns 20131205 ./shared/zdb_resources.rdf to YAML

## tack namespace prefixes in config

In `catmandu.yml`:

```yaml
---
importer:
  RDF:
    package: RDF
    options:
      ns: 20140101
...
```

## Mapping RDF graphs to records

Another RDF encoding Form (aREF)\
<http://gbv.github.io/aREF/>

* abbreviate URIs with underscore 
  (`dc_title`, `foaf_Person`...)
* aREF query language
* `aref_query` fix:\
  `aref_query(query:dct_title, field:title)`

## Reading RDF data

<https://github.com/LibreCat/Catmandu-RDF/wiki/Reading-RDF-Data>
  

