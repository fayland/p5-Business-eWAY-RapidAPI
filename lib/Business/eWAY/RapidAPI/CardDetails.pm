package Business::eWAY::RapidAPI::CardDetails;

use Moo;
use MooX::Types::MooseLike::Base qw(:all);

has $_ => (is => 'rw', isa => Str) foreach ('Name', 'Number', 'ExpiryMonth', 'ExpiryYear', 'StartMonth', 'StartYear', 'IssueNumber', 'CVN');

sub TO_JSON { return { %{ $_[0] } }; }

no Moo;

1;