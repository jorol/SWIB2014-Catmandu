# Catmandu VM

## Installation

OS: Debian 7.6.0 i386

User: catmandu

PWD: catmandu

```terminal
su -
apt-get upgrade
apt-get install build-essential libexpat1-dev libssl-dev libxml2-dev libxslt1-dev libgdbm-dev git curl wget

wget -O 10gen-gpg-key.asc http://docs.mongodb.org/10gen-gpg-key.asc
apt-key add 10gen-gpg-key.asc
echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' | tee /etc/apt/sources.list.d/mongodb.list
apt-get update
apt-get install mongodb

apt-get install openjdk-7-jre-headless
wget -O elascticsearch-key.asc - http://packages.elasticsearch.org/GPG-KEY-elasticsearch
apt-key add elascticsearch-key.asc
echo 'deb http://packages.elasticsearch.org/elasticsearch/1.3/debian stable main' | tee /etc/apt/sources.list.d/elasticsearch.list
apt-get update
apt-get install elasticsearch

cpan App::cpanminus
cpanm Task::Catmandu
cpanm Catmandu::PICA
cpanm Catmandu::MAB2
cpanm Catmandu::XML
cpanm Catmandu::RDF
cpanm Catmandu::Wikidata

cpanm Mango

shutdown -h now
```
