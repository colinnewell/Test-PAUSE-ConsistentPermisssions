package Test::PAUSE::ConsistentPermissions;

use strictures 2;
use Test::PAUSE::ConsistentPermissions::Check;
use parent 'Exporter';
use Test::More;
use Parse::LocalDistribution;

our @EXPORT = (@Test::More::EXPORT, qw/all_permissions_consistent/);

sub all_permissions_consistent
{
    my $authority_with = shift;

    # FIXME: is RELEASE_TESTING the appropriate time for this??
    plan skip_all => 'Set RELEASE_TESTING environmental variable to test this.' unless $ENV{RELEASE_TESTING};

    my $provides = Parse::LocalDistribution->new->parse();
    my $checker = Test::PAUSE::ConsistentPermissions::Check->new();
    my $results = $checker->report_problems([keys %$provides], $authority_with);
    if(@{$results->{problems}})
    {
        fail "There were problems";
    }
    else
    {
        pass 'All permissions consistent with ' . $authority_with;
    }
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

