package Test::PAUSE::ConsistentPermissions::Check;

use strictures 2;

use Moo;
use PAUSE::Permissions;
use List::Compare;

has permissions_client => (is => 'ro', lazy => 1, builder => '_build_permissions_client');

sub _build_permissions_client
{
    my $self = shift;
    my $pp = PAUSE::Permissions->new(preload => 1, max_age => '1 day');
    return $pp;
}

sub report_problems
{
    my $self = shift;
    my $modules = shift;
    my $authority_from = shift;

    my $pp = $self->permissions_client;
    my $master = $pp->module_permissions($authority_from);
    my $owner = $master->owner;
    my @comaint = $master->co_maintainers;

    my @problem_list;
    for my $module (@$modules)
    {
        my $mp = $pp->module_permissions($module);
        my $mod_owner = $mp->owner;
        my @mc = $mp->co_maintainers;
        my $problems = {};
        if($mod_owner ne $owner)
        {
            $problems->{different_owner} = $mod_owner;
        }
        my $lc = List::Compare->new(\@comaint, \@mc);
        unless($lc->is_LequivalentR)
        {
            my @missing = $lc->get_unique();
            my @extra = $lc->get_complement();
            $problems->{missing} = \@missing if @missing;
            $problems->{extra} = \@extra if @extra;
        }
        if(%$problems)
        {
            push @problem_list, { module => $module, issues => $problems };
        }
    }

    return {
        module => $authority_from,
        owner => $owner,
        comaint => \@comaint,
        problems => \@problem_list,
    };
}

# achieve: 
# report incorrect owner.  
# report missing comaint.

1;

=head1 NAME

Test::PAUSE::ConsistentPermissions::Check - Class used to check permissions.

=head1 DESCRIPTION

=head1 METHODS

=head2 report_problems

=head1 ATTRIBUTES

=head2 permissions_client

This is the L<PAUSE::Permissions> object used to check the PAUSE permissions.

=cut
