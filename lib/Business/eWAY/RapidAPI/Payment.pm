package Business::eWAY::RapidAPI::Payment;

use Moo;
use MooX::Types::MooseLike::Base qw(:all);

has $_ => (is => 'rw', isa => Str) foreach ('TotalAmount', 'InvoiceNumber', 'InvoiceDescription', 'InvoiceReference', 'CurrencyCode');

sub TO_JSON { return { %{ $_[0] } }; }

no Moo;

1;