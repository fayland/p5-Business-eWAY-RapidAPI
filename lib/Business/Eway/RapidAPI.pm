package Business::Eway::RapidAPI;

# ABSTRACT: PunchTab REST API

use Moo;
use Business::Eway::RapidAPI::CreateAccessCodeRequest;
use Business::Eway::RapidAPI::GetAccessCodeResultRequest;
use Data::Dumper;
use WWW::Mechanize;

with 'Business::Eway::RapidAPI::Role::Parser';
with 'Business::Eway::RapidAPI::Role::ErrorCodeMap';

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
has 'ShowDebugInfo' => (is => 'lazy');
sub _build_ShowDebugInfo { (shift)->debug }

has 'Request_Method' => (is => 'rw', required => 1, default => sub {'REST'});
has 'Request_Format' => (is => 'rw', required => 1, default => sub {'JSON'});

has 'ua' => (is => 'lazy');
sub _build_ua {
    my $self = shift;
    return WWW::Mechanize->new(timeout => 60, autocheck => 0, stack_depth => 1, ssl_opts => { verify_hostname => 0 });
}

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

sub CreateAccessCode {
    my ($self, $request) = @_;

    if ($self->debug) {
        print STDERR "Request Ojbect for CreateAccessCode: \n";
        print STDERR Dumper(\$request) . "\n";
    }

    my $Request_Method = $self->Request_Method;
    my $Request_Format = $self->Request_Format;

    ## Request_Method eq 'RPC' is not implemented yet
    $Request_Method = 'REST' if $Request_Method eq 'RPC';

    if ($Request_Method ne 'SOAP') {
        if ($Request_Format eq "XML") {
            if ($Request_Method ne 'RPC') {
                $request = $self->Obj2XML($request, 'CreateAccessCode');
            } else {
                $request = $self->Obj2RPCXML("CreateAccessCode", $request);
            }
        } else {
            if ($Request_Method ne 'RPC') {

                # fixes
                $request = $self->Obj2ARRAY($request);
                $request->{Items} = delete $request->{Items}->{LineItem};
                $request->{Options} = delete $request->{Options}->{Option};

                $request = $self->Obj2JSON($request);
            } else {
                $request = $self->Obj2JSONRPC("CreateAccessCode", $request);
            }
        }
    } else {
        $request = $self->Obj2ARRAY($request);
    }

    if ($self->debug) {
        print "Request String for CreateAccessCode: \n";
        print STDERR Dumper(\$request) . "\n";
    }

    my $method = 'CreateAccessCode' . $Request_Method;
    my $response = $self->$method($request);

    if ($self->debug) {
        print "Response String for CreateAccessCode: \n";
        print STDERR Dumper(\$response) . "\n";
    }

    # Convert Response Back TO An Object
    my $result;
    if ($Request_Method ne 'SOAP') {
        if ($Request_Format eq "XML") {
            if ($Request_Method ne 'RPC') {
                $result = $self->XML2Obj($response);
            } else {
                $result = $self->RPCXML2Obj($response);
            }
        } else {
            if ($Request_Method ne 'RPC') {
                $result = $self->JSON2Obj($response);
            } else {
                $result = $self->JSONRPC2Obj($response);
            }
        }
    } else {
        $result = $request;
    }

    # Is Debug Mode
    if ($self->debug) {
        print "Response Object for CreateAccessCode: \n";
        print STDERR Dumper(\$result) . "\n";
    }

    return $result;
}

sub CreateAccessCodeREST {
    my ($self, $request) = @_;

    return $self->PostToRapidAPI($self->urls->{'PaymentService.REST'} . "s", $request);
}

sub GetAccessCodeResult {
    my ($self, $request) = @_;

    if ($self->debug) {
        print STDERR "Request Ojbect for GetAccessCodeResult: \n";
        print STDERR Dumper(\$request) . "\n";
    }

    my $Request_Method = $self->Request_Method;
    my $Request_Format = $self->Request_Format;

    ## Request_Method eq 'RPC' is not implemented yet
    $Request_Method = 'REST' if $Request_Method eq 'RPC';

    if ($Request_Method ne 'SOAP') {
        if ($Request_Format eq "XML") {
            if ($Request_Method ne 'RPC') {
                $request = $self->Obj2XML($request, 'GetAccessCodeResult');
            } else {
                $request = $self->Obj2RPCXML("GetAccessCodeResult", $request);
            }
        } else {
            if ($Request_Method ne 'RPC') {
                $request = $self->Obj2JSON($request);
            } else {
                $request = $self->Obj2JSONRPC("GetAccessCodeResult", $request);
            }
        }
    } else {
        $request = $self->Obj2ARRAY($request);
    }

    if ($self->debug) {
        print "Request String for GetAccessCodeResult: \n";
        print STDERR Dumper(\$request) . "\n";
    }

    my $method = 'GetAccessCodeResult' . $Request_Method;
    my $response = $self->$method($request);

    if ($self->debug) {
        print "Response String for GetAccessCodeResult: \n";
        print STDERR Dumper(\$response) . "\n";
    }

    # Convert Response Back TO An Object
    my $result;
    if ($Request_Method ne 'SOAP') {
        if ($Request_Format eq "XML") {
            if ($Request_Method ne 'RPC') {
                $result = $self->XML2Obj($response);
            } else {
                $result = $self->RPCXML2Obj($response);
            }
        } else {
            if ($Request_Method ne 'RPC') {
                $result = $self->JSON2Obj($response);
            } else {
                $result = $self->JSONRPC2Obj($response);
            }
        }
    } else {
        $result = $request;
    }

    # Is Debug Mode
    if ($self->debug) {
        print "Response Object for GetAccessCodeResult: \n";
        print STDERR Dumper(\$result) . "\n";
    }

    return $result;
}

sub GetAccessCodeResultREST {
    my ($self, $request) = @_;

    return $self->PostToRapidAPI($self->urls->{'PaymentService.REST'} . "/" . $request->AccessCode, $request);
}

sub PostToRapidAPI {
    my ($self, $url, $request) = @_;

    my $Request_Format = $self->Request_Format;

    my $content_type;
    if ($Request_Format eq "XML") {
	    $content_type = "text/xml";
    } else {
	    $content_type = "application/json";
    }

    my $ua = $self->ua;
    $ua->credentials( $self->username, $self->password );
    my $resp = $ua->post($url,
        Content => $request,
        'Content-Type' => $content_type
    );

    unless ($resp->is_success) {
        print '<h2>POST Error: ' . $resp->status_line . ' URL: ' . $url. ' </h2> <pre>';
        die Dumper(\$resp);
    }

    return $resp->decoded_content;
}

1;
