use strict;
use v5.10;

use Catmandu ':all';
use Catmandu::Plack::unAPI;

# for instance: "10.2474/trol.7.147"
# see also http://www.doi2bib.org/

{
    package aREF2JSON;
    use parent 'Catmandu::Fix';
    use RDF::aREF ':all';

    sub aref_mapping { # TODO: move to RDF::aREF
        my ($rdf, $uri, $mapping) = @_;

        # TODO: set $uri from _id or _url?
        my %result;

        while (my ($field, $query) = each %$mapping) {
            my @values = aref_query( $rdf, $uri, $query );
            if (@values) {
                $result{$field} = @values > 1 ? \@values : $values[0];
            }
        }

        \%result;
    }

    sub fix {
        my ($self, $data) = @_;
        aref_mapping($data, $data->{_url}, {
            title     => 'dct_title',
            creators  => 'dct_creator.foaf_name',
            pageStart => 'bibo_pageStart',
            pageEnd   => 'bibo_pageEnd',
            volume    => 'bibo_volume',
            doi       => 'bibo_doi',
            publisher => 'dct_publisher',
            year      => 'dct_date^xs_gYear', 
            journal   => 'dct_partOf.dct_title',
        });
    }
}
my $aref2json = aREF2JSON->new(fixes => []);

{
    package aREF2MODS;
    use parent 'Catmandu::Fix';
    use Moo;
    has aref2json => (is => 'ro');
    sub fix {
        my ($self, $data) = @_;
        $data = $self->aref2json->fix($data);
        my $mods = [ mods => { xmlns => "http://www.loc.gov/mods/v3" }, [
    [ titleInfo => [
        [ title => [$data->{title}]]
    ]],
    # <name type="personal">
    # <typeOfResource>text</typeOfResource>
    # <genre>journal article</genre>
    [ originInfo => [
        [ publisher => [ $data->{publisher} ] ]
    ]],
    # <relatedItem type="host">
]];
    }
}
my $aref2mods = aREF2MODS->new(fixes => [], aref2json => $aref2json);


Catmandu::Plack::unAPI->new(
    # Get DOI data via RDF Linked Open Data
    query => sub {
        if ($_[0] !~ qr{^(doi:|https?://dx\.doi\.org/)?10\.\d+/\S+$}) {
            return 'invalid DOI'
        }
        my $url = "http://dx.doi.org/".$_[0];
        my $rdf = importer('RDF', url => $url)->first;
        $rdf->{_url} = $url if $rdf;
        return $rdf;
    },
    # supported formats
    formats => {
        arefjson => {
            type => 'application/json',
            exporter => [ 'JSON', pretty => 1 ],
            docs => 'http://gbv.github.io/aREF/'
        },
        arefyaml => {
            type => 'text/yaml',
            exporter => 'YAML',
            docs => 'http://gbv.github.io/aREF/'
        },
        rdfxml => {
            type => 'application/rdf+xml',
            exporter => ['RDF', type => 'rdfxml']
        },
        json => {
            type => 'application/json',
            exporter => [ 'JSON', pretty => 1, fix => $aref2json ],
        },
        mods => {
            type => 'application/xml',
            exporter => [ 'XML', pretty => 1, fix => $aref2mods ],
        },
    }
)->to_app;
