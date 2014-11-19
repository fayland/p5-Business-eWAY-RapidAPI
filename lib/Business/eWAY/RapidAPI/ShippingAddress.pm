package Business::eWAY::RapidAPI::ShippingAddress;

use Moo;
use MooX::Types::MooseLike::Base qw(:all);

has $_ => (is => 'rw', isa => Str) foreach ('ShippingMethod', 'FirstName', 'LastName', 'Street1', 'Street2', 'City', 'State', 'PostalCode', 'Country', 'Email', 'Phone', 'Fax');

sub TO_JSON { return { %{ $_[0] } }; }

no Moo;

1;