package Business::eWAY::RapidAPI::CardDetails;

use Moo;
use MooX::Types::MooseLike::Base qw(:all);

has $_ => (is => 'rw', isa => Str) foreach ('Name', 'Number', 'ExpiryMonth', 'ExpiryYear', 'StartMonth', 'StartMonth', 'IssueNumber', 'CVN');

no Moo;

1;