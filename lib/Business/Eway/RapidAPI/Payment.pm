package Business::eWAY::RapidAPI::Payment;

use Moo;
use MooX::Types::MooseLike::Base qw(:all);

has $_ => (is => 'rw', isa => Str) foreach ('TotalAmount', 'InvoiceNumber', 'InvoiceDescription', 'InvoiceReference', 'CurrencyCode');

1;