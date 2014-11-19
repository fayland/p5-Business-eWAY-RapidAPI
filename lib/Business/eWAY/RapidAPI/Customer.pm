package Business::eWAY::RapidAPI::Customer;

use Moo;
use MooX::Types::MooseLike::Base qw(:all);

has $_ => (is => 'rw', isa => Str) foreach ('TokenCustomerID', 'Reference', 'Title', 'FirstName', 'LastName', 'CompanyName', 'JobDescription', 'Street1', 'Street2', 'City', 'State', 'PostalCode', 'Country', 'Email', 'Phone', 'Mobile', 'Comments', 'Fax', 'Url');

sub TO_JSON { return { %{ $_[0] } }; }

no Moo;

1;