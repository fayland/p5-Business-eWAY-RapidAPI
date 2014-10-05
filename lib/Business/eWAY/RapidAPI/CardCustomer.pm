package Business::eWAY::RapidAPI::CardCustomer;

use Moo;
use MooX::Types::MooseLike::Base qw(:all);
use Business::eWAY::RapidAPI::CardDetails;

extends 'Business::eWAY::RapidAPI::Customer';

has 'CardDetails' => (is => 'lazy', isa => InstanceOf['Business::eWAY::RapidAPI::CardDetails']);
sub _build_CardDetails { Business::eWAY::RapidAPI::CardDetails->new }

no Moo;

1;