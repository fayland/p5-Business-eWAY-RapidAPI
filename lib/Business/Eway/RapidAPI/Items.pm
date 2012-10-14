package Business::Eway::RapidAPI::Items;

use Moo;
use MooX::Types::MooseLike::Base qw(:all);
use Business::Eway::RapidAPI::LineItem;

has 'LineItem' => (is => 'rw', isa => ArrayRef[InstanceOf['Business::Eway::RapidAPI::LineItem']], default => sub { [] });

1;