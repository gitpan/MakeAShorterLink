package MakeAShorterLink;

use 5.006;
use strict;
use warnings;

require Exporter;

our @ISA = qw(Exporter);
our @EXPORT = qw(makeashorterlink);
our $VERSION = sprintf "%d.%02d", '$Revision: 1.2 $ ' =~ /(\d+)\.(\d+)/;

use LWP;
use URI::Escape;
use Carp;

# Preloaded methods go here.
sub makeashorterlink {
  my $masl = 'http://www.makeashorterlink.com/index.php';
  my $url = shift or croak 'No URL passed to makeashorterlink';

  my $ua = LWP::UserAgent->new;

  my $resp = $ua->post($masl,
                       [ url => $url ]);

  return unless $resp->is_success;

  if ($resp->content =~ m!Your shorter link is: <a href="(.*)">!) {
    return $1;
  }
}

1;
__END__
# Below is stub documentation for your module. You better edit it!

=head1 NAME

MakeAShorterLink - Perl interface to makeashorterlink.com

=head1 SYNOPSIS

  use MakeAShorterLink;

  my $short_url = makeashorterlink($long_url);

=head1 DESCRIPTION

A Perl interface to the web site makeashorterlink.com (MASL to its
friends). MASL simply maintains a database of long URLs, each of which
has a unique identifier.

MakeAShorterLink.pm will call the MASL web site passing it your long
URL and will return the shorter MASL version.

If anything goes wrong, then the C<makeashorterlink> function will
return C<undef>.

=head2 EXPORT

makeashorterlink

=head1 AUTHOR

Dave Cross <dave@dave.org.uk>
(with help from Alex Page <grimoire@corinne.cpio.org>)

=head1 SEE ALSO

L<perl>, L<http://makeashorterlink.com/>

=cut
