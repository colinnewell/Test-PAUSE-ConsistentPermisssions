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

    # FIXME: figure out default to use for Authority.

    # FIXME: is RELEASE_TESTING the appropriate time for this??
    plan skip_all => 'Set RELEASE_TESTING environmental variable to test this.' unless $ENV{RELEASE_TESTING};

    my $provides = Parse::LocalDistribution->new->parse();
    my $checker = Test::PAUSE::ConsistentPermissions::Check->new();
    my $results = $checker->report_problems([keys %$provides], $authority_with);
    my $notes = '';
    open my $nh, '>', \$notes;
    $checker->module_info_to_fh($results, $nh);
    close($nh);
    note($notes);
    if(@{$results->{problems}})
    {
        my $problems = '';
        open my $ph, '>', \$problems;
        $checker->problems_to_fh($results, $ph);
        close($ph);
        fail $problems;
    }
    else
    {
        pass 'All permissions consistent with ' . $authority_with;
    }
}

=head1 NAME

Test::PAUSE::ConsistentPermissions - Check your PAUSE permissions are consistent in your distribution.

=head1 DESCRIPTION

This module is designed to check the permissions of this distribution and ensure that they
are consistent.  This checks that for all the modules in the distribution the owner and comaintainer
are the same.

To perform your own checks in some way other than a simple test look at the 
L<Test::PAUSE::ConsistentPermissions::Check> module.

Note that this is different to checking that the current author has permission to upload this module.

    use Test::More;
    use Test::PAUSE::ConsistentPermissions;

    all_permissions_consistent 'Test::PAUSE::ConsistentPermissions';

    done_testing;


=head1 FUNCTIONS

=head2 all_permissions_consistent


=head1 SEE ALSO

=over 

=item * App::PAUSE::CheckPerms

An application to check if an authors permissions are consistent.

=item * Test::PAUSE::Permissions

This module allows you to ensure that you will be able to upload your module
succesfully.

The test part of this module is heavily based on that module.

=back

=cut

