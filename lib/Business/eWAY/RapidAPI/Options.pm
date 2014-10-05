package Business::eWAY::RapidAPI::Options;

use Moo;
use MooX::Types::MooseLike::Base qw(:all);

has 'Option' => (is => 'rw', isa => ArrayRef[InstanceOf['Business::eWAY::RapidAPI::Option']], default => sub { [] });

no Moo;

package # hidden from PAUSE
    Business::eWAY::RapidAPI::Option;

use Moo;
use MooX::Types::MooseLike::Base 'Str';

has 'Value' => (is => 'rw', isa => Str);

no Moo;

1;