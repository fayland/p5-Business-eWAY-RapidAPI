#!/usr/bin/perl

use strict;
use warnings;
use Business::Eway::RapidAPI;

my $rapidapi = Business::Eway::RapidAPI->new(
    username => "44DD7C70Jre1dVgIsULcEyi+A+/cX9V5SAHkIiyVdWrHRG2tZm0rdintfZz85Pa/kGwq/1",
    password => "Abcd1234",
);

my $request = Business::Eway::RapidAPI::CreateAccessCodeRequest->new();
$request->Customer->Reference('XXX');



my $item1 = Business::Eway::RapidAPI::LineItem->new();
$item1->SKU("SKU1");
$item1->Description("Description1");
my $item2 = Business::Eway::RapidAPI::LineItem->new();
$item2->SKU("SKU2");
$item2->Description("Description2");
$request->Items->LineItem([ $item1, $item2 ]);

use Data::Dumper;
print Dumper(\$rapidapi, \$request);

1;