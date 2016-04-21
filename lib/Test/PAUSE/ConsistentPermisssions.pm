package Test::PAUSE::ConsistentPermisssions;

use strictures 2;

use Moo;
use Parse::LocalDistribution;
use PAUSE::Permissions;

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
    my $module = shift;
    my $pp = $self->permissions_client;
    # FIXME: also need to figure out what files are currently part of the distro.
    # can't tell that from the permissions file.
    # Could use Parse::LocalDistribution if we're working on a local dist.
    my $mp = $pp->module_permissions('HTTP::Client');
    my $owner    = $mp->owner;
    my @comaints = $mp->co_maintainers;

}

sub get_current_dist_modules
{
    my $self = shift;
    my $provides = Parse::LocalDistribution->new->parse();

}


# achieve: 
# report incorrect owner.  
# report missing comaint.

1;
