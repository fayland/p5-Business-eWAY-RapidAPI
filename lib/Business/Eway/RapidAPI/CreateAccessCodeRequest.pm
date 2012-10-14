package Business::Eway::RapidAPI::CreateAccessCodeRequest;

use Moo;
use MooX::Types::MooseLike::Base qw(:all);

use Business::Eway::RapidAPI::Customer;
use Business::Eway::RapidAPI::Items;

has $_ => (is => 'rw', isa => Str) foreach ('RedirectUrl', 'IPAddress', 'DeviceID', 'Method');
has 'Customer' => (is => 'lazy', isa => InstanceOf['Business::Eway::RapidAPI::Customer']);
sub _build_Customer { Business::Eway::RapidAPI::Customer->new }
has 'Items' => (is => 'lazy', isa => InstanceOf['Business::Eway::RapidAPI::Items']);
sub _build_Items { Business::Eway::RapidAPI::Items->new }

#$Payment,
#$ShippingAddress,
#$Items,
#$Options

1;