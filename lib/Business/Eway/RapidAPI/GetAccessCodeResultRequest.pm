package Business::eWAY::RapidAPI::GetAccessCodeResultRequest;

use Moo;
use MooX::Types::MooseLike::Base qw(:all);

has 'AccessCode' => (is => 'rw', isa => Str);

1;