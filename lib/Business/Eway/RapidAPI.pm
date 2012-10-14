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

#sub

1;
