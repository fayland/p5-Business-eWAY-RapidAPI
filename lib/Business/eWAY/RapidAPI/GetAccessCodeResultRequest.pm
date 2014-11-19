package Business::eWAY::RapidAPI::GetAccessCodeResultRequest;

use Moo;
use MooX::Types::MooseLike::Base qw(:all);

has 'AccessCode' => (is => 'rw', isa => Str);

sub TO_JSON { return { %{ $_[0] } }; }

no Moo;

1;