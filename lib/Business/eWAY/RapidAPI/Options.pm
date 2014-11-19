package Business::eWAY::RapidAPI::Options;

use Moo;
use MooX::Types::MooseLike::Base qw(:all);

has 'Option' => (is => 'rw', isa => ArrayRef[InstanceOf['Business::eWAY::RapidAPI::Option']], default => sub { [] });

sub TO_JSON { return { %{ $_[0] } }; }

no Moo;

package # hidden from PAUSE
    Business::eWAY::RapidAPI::Option;

use Moo;
use MooX::Types::MooseLike::Base 'Str';

has 'Value' => (is => 'rw', isa => Str);

sub TO_JSON { return { %{ $_[0] } }; }

no Moo;

1;