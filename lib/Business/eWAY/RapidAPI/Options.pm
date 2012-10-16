package Business::eWAY::RapidAPI::Options;

use Moo;
use MooX::Types::MooseLike::Base qw(:all);

has 'Option' => (is => 'rw', isa => ArrayRef[InstanceOf['Business::eWAY::RapidAPI::Option']], default => sub { [] });

package # hidden from PAUSE
    Business::eWAY::RapidAPI::Option;

use Moo;
use MooX::Types::MooseLike::Base qw(:all);

has 'Value' => (is => 'rw', isa => Str);

1;