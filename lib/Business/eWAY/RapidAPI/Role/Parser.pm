package Business::eWAY::RapidAPI::Role::Parser;

use Moo::Role;

use JSON::MaybeXS;
use XML::Simple;

sub Obj2ARRAY {
    my ($self, $obj) = @_;

    my $json = JSON::MaybeXS->new(convert_blessed => 1);
    return $json->decode($json->encode($obj));
}

sub Obj2JSON {
    my ($self, $obj) = @_;

    my $json = JSON::MaybeXS->new(convert_blessed => 1);
    return $json->encode($obj);
}

sub JSON2Obj {
    my ($self, $obj) = @_;

    my $json = JSON::MaybeXS->new(convert_blessed => 1);
    return $json->decode($obj);
}

sub Obj2XML {
    my ($self, $obj, $reqname) = @_;

    my $xs = XML::Simple->new(GroupTags=>{'Items'=>'LineItem','Options'=>'Option'}, SuppressEmpty=>1);
    return $xs->XMLout($obj, KeepRoot => 0, XMLDecl => 1, NoAttr => 1, RootName => $reqname);
}

sub XML2Obj {
    my ($self, $obj) = @_;

    my $xs = XML::Simple->new(SuppressEmpty=>1);

    return $xs->XMLin($obj, ForceArray => ['Items','Options'], KeepRoot => 0, ForceContent => 0);
}

no Moo::Role;

1;