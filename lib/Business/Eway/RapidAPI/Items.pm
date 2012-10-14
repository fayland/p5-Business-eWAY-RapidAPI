package Business::Eway::RapidAPI::Items;

use Moo;
use MooX::Types::MooseLike::Base qw(:all);

has 'LineItem' => (is => 'rw', isa => ArrayRef[InstanceOf['Business::Eway::RapidAPI::LineItem']], default => sub { [] });

package # hidden from PAUSE
    Business::Eway::RapidAPI::LineItem;

use Moo;
use MooX::Types::MooseLike::Base qw(:all);

has $_ => (is => 'rw', isa => Str) foreach ('SKU', 'Description', 'Quantity', 'UnitCost', 'Tax', 'Total');

1;

1;