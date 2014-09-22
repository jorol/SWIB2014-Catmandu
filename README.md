# Catmandu - Importing, transforming, storing and indexing data should be easy

SWIB2014 1 - 3 December 2014 Bonn, Germany

Johann Rolschewski / Jakob Voß

Staatsbibliothek zu Berlin, Germany / Verbundzentrale des GBV (VZG), Germany

## Abstract

Catmandu provides a suite of software modules to ease the import, storage, retrieval, export and transformation of metadata records. Combine Catmandu modules with web application frameworks such as PSGI/Plack, document stores such as MongoDB and full text indexes such as Elasticsearch to create a rapid development environment for digital library services. After a short introduction to Catmandu and its features, we will present the domain specific language (DSL) and command line interface (CLI). Participants will be guided to transform (their) data records to a common metadata model, to store/index it in Elasticsearch or MongoDB and to export it as Linked Data.

## Prior Experience

We will be using a simplified DSL language. Participants should be familiar with command line interfaces (CLI). Any programming experience is welcome but not required.

## Requirements

Laptop with VirtualBox installed. Organisers will provide a virtualbox image (Linux guest system) beforehand. You can also install your own environment, see "[Installation](https://github.com/LibreCat/Catmandu/wiki/Installation)". Participants should bring their own data (CSV, JSON, MAB2, MARC, PICA+, RDF or YAML).

## Agenda

  * Introduction to LibreCat and Catmandu
      - Project LibreCat
      - Software Catmandu
  * The command line interface (CLI)
      - Introduction
      - Formats: JSON, MAB2, MARC, PICA, YAML, XLS
      - Stores: MongoDB & Elasticsearch
      - APIs: getJSON, OAI, SRU
      - Configuration
  * The domain specific language
      - Introduction
      - Fixes
      - Dictionaries
  * RDF
      - Introduction
      - Import RDF data
      - Export RDF data
  * Overview of Catmandu architecture
      - Catmandu::Importer
      - Catmandu::Fix
      - Catmandu::Cmd

## Links

[librecat.org](http://librecat.org/)

[LibreCat:github](https://github.com/LibreCat/)

[Catmandu:wiki](https://github.com/LibreCat/Catmandu/wiki/)

[Catmandu:cpan](https://metacpan.org/search?q=Catmandu)

[MAB2](http://www.ubka.uni-karlsruhe.de/hylib/mab/mab2.html)

[MARC](http://www.loc.gov/marc/bibliographic/)

[KIM:RDF](https://wiki.dnb.de/pages/viewpage.action?pageId=68060017)

[PICA](http://www.gbv.de/bibliotheken/verbundbibliotheken/02Verbund/01Erschliessung/02Richtlinien/01KatRicht/inhalt.shtml)

[MongoDB](http://www.mongodb.org/)

[Elasticsearch](http://www.elasticsearch.org/)