package Business::Eway::RapidAPI;

# ABSTRACT: PunchTab REST API

use Moo;
use Business::Eway::RapidAPI::CreateAccessCodeRequest;

has 'mode' => (is => 'rw', default => sub {'live'});
has 'urls' => (is => 'lazy');
sub _build_urls {
    my $self = shift;
    if ($self->mode eq 'live') {
        return {
            'PaymentService.Soap' => 'https://api.ewaypayments.com/soap.asmx?WSDL',
            'PaymentService.POST.CreateAccessCode' => 'https://api.ewaypayments.com/CreateAccessCode.xml',
            'PaymentService.POST.GetAccessCodeResult' => 'https://api.ewaypayments.com/GetAccessCodeResult.xml',
            'PaymentService.REST' => 'https://api.ewaypayments.com/AccessCode',
            'PaymentService.RPC' => 'https://api.ewaypayments.com/json-rpc',
            'PaymentService.JSONPScript' => 'https://api.ewaypayments.com/JSONP/v1/js',
        }
    } else {
        return {
            'PaymentService.Soap' => 'https://api.sandbox.ewaypayments.com/Soap.asmx?WSDL',
            'PaymentService.POST.CreateAccessCode' => 'https://api.sandbox.ewaypayments.com/CreateAccessCode.xml',
            'PaymentService.POST.GetAccessCodeResult' => 'https://api.sandbox.ewaypayments.com/GetAccessCodeResult.xml',
            'PaymentService.REST' => 'https://api.sandbox.ewaypayments.com/AccessCode',
            'PaymentService.RPC' => 'https://api.sandbox.ewaypayments.com/json-rpc',
            'PaymentService.JSONPScript' => 'https://api.sandbox.ewaypayments.com/JSONP/v1/js',
        }
    }
}

has 'username' => (is => 'rw', required => 1);
has 'password' => (is => 'rw', required => 1);
has 'debug'    => (is => 'rw', default => sub {0});

=head1 SYNOPSIS

    use Business::Eway::RapidAPI;

    my $rapidapi = Business::Eway::RapidAPI->new(
        username => "44DD7C70Jre1dVgIsULcEyi+A+/cX9V5SAHkIiyVdWrHRG2tZm0rdintfZz85Pa/kGwq/1",
        password => "Abcd1234",
    );

    my $request = Business::Eway::RapidAPI::CreateAccessCodeRequest->new();
    $request->Customer->Reference('My Reference');

    my $item1 = Business::Eway::RapidAPI::LineItem->new();
    $item1->SKU("SKU1");
    $item1->Description("Description1");
    my $item2 = Business::Eway::RapidAPI::LineItem->new();
    $item2->SKU("SKU2");
    $item2->Description("Description2");
    $request->Items->LineItem([ $item1, $item2 ]);

    my $opt1 = Business::Eway::RapidAPI::Option->new(Value => 'Test1');
    my $opt2 = Business::Eway::RapidAPI::Option->new(Value => 'Test2');
    $request->Options->Option([$opt1, $opt2]);

=head1 DESCRIPTION

eWAY RapidAPI

=head2 METHODS

=head3 CONSTRUCTION

    my $rapidapi = Business::Eway::RapidAPI->new(
        mode => 'test',
        username => "44DD7C70Jre1dVgIsULcEyi+A+/cX9V5SAHkIiyVdWrHRG2tZm0rdintfZz85Pa/kGwq/1",
        password => "Abcd1234",
    );

=over 4

=item * mode

default 'live'

=item * username

required

=item * password

required

=item * debug

default 0

=back

=cut

#sub

1;
