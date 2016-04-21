package Test::PAUSE::ConsistentPermissions;

use strictures 2;

use Moo;
use Parse::LocalDistribution;
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
            $problems->{different_owner} = $owner;
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
            push @problem_list, { module => $problems };
        }
    }

    return {
        module => $authority_from,
        owner => $owner,
        comaint => \@comaint,
        problems => \@problem_list,
    };
}

# FIXME: provide a method that will check the current module
# using Parse::LocalDistribution
# sub get_current_dist_modules
# {
#     my $self = shift;
#     my $provides = Parse::LocalDistribution->new->parse();
# 
#     return $provides;
# }


# achieve: 
# report incorrect owner.  
# report missing comaint.

1;
