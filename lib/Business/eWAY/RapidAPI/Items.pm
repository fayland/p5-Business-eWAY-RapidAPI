package Business::eWAY::RapidAPI::Items;

use Moo;
use MooX::Types::MooseLike::Base qw(:all);

has 'LineItem' => (is => 'rw', isa => ArrayRef[InstanceOf['Business::eWAY::RapidAPI::LineItem']], default => sub { [] });

no Moo;

package # hidden from PAUSE
    Business::eWAY::RapidAPI::LineItem;

use Moo;
use MooX::Types::MooseLike::Base qw(:all);

has $_ => (is => 'rw', isa => Str) foreach ('SKU', 'Description', 'Quantity', 'UnitCost', 'Tax', 'Total');

no Moo;

1;