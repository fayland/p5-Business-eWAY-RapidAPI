package Business::Eway::RapidAPI::LineItem;

use Moo;
use MooX::Types::MooseLike::Base qw(:all);

has $_ => (is => 'rw', isa => Str) foreach ('SKU', 'Description', 'Quantity', 'UnitCost', 'Tax', 'Total');

1;