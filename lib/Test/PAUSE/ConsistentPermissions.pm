package Test::PAUSE::ConsistentPermissions;

use strictures 2;
use Test::PAUSE::ConsistentPermissions::Check;
use parent 'Exporter';
use Test::More;
use Parse::LocalDistribution;

our @EXPORT = (@Test::More::EXPORT, qw/all_permissions_consistent/);

sub all_permissions_consistent
{
    plan skip_all => 'Set RELEASE_TESTING environmental variable to test this.' unless $ENV{RELEASE_TESTING};

}

=head1 NAME

Test::PAUSE::ConsistentPermissions - Check your PAUSE permissions are consistent in your distribution.

=head1 DESCRIPTION

=head1 METHODS


=head1 SEE ALSO

=over 

=item * Test::PAUSE::Permissions

The test part of this module is heavily based on that module.

=back

=cut

