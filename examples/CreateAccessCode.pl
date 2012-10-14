#!/usr/bin/perl

use strict;
use warnings;
use FindBin qw/$Bin/;
use lib "$Bin/../lib";
use Business::Eway::RapidAPI;

my $rapidapi = Business::Eway::RapidAPI->new(
    username => "44DD7C70Jre1dVgIsULcEyi+A+/cX9V5SAHkIiyVdWrHRG2tZm0rdintfZz85Pa/kGwq/1",
    password => "Abcd1234",
);

my $request = Business::Eway::RapidAPI::CreateAccessCodeRequest->new();
$request->Customer->Reference('My Reference');


$request->ShippingAddress->FirstName("John");
$request->ShippingAddress->LastName("Doe");
$request->ShippingAddress->Street1("9/10 St Andrew");
$request->ShippingAddress->Street2(" Square");
$request->ShippingAddress->City("Edinburgh");
$request->ShippingAddress->State("");
$request->ShippingAddress->Country("gb");
$request->ShippingAddress->PostalCode("EH2 2AF");
$request->ShippingAddress->Email('sales@eway.co.uk');
$request->ShippingAddress->Phone("0131 208 0321");
# ShippingMethod, e.g. "LowCost", "International", "Military". Check the spec for available values.
$request->ShippingAddress->ShippingMethod("LowCost");


my $item1 = Business::Eway::RapidAPI::LineItem->new();
$item1->SKU("SKU1");
$item1->Description("Description1");
my $item2 = Business::Eway::RapidAPI::LineItem->new();
$item2->SKU("SKU2");
$item2->Description("Description2");
$request->Items->LineItem([ $item1, $item2 ]);

my $opt1 = Business::Eway::RapidAPI::Option->new(Value => 'Test1');
my $opt2 = Business::Eway::RapidAPI::Option->new(Value => 'Test2');
$request->Options->Option([$opt1, $opt2]);

$request->Payment->TotalAmount(100);
$request->Payment->InvoiceNumber(12345);
$request->Payment->InvoiceDescription('Test DESC');
$request->Payment->InvoiceReference('Test Inv. Ref.');
$request->Payment->CurrencyCode('AUD');

$request->RedirectUrl('http://fayland.org/');

use Data::Dumper;
print Dumper(\$rapidapi, \$request);

1;