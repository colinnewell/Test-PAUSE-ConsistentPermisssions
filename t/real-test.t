use Test::Most;
use Test::PAUSE::ConsistentPermissions::Check;

BEGIN {
    plan skip_all => 'Set LIVE_TEST environmental variable to test this.' unless $ENV{LIVE_TEST};
}

# FIXME: make sure this is optional.
use PAUSE::Packages;

# FIXME: make use of local file.
# then we don't need the guff (perhaps)
my $pp = PAUSE::Packages->new;
my $release_info = $pp->release('OpusVL-AppKit');
my @modules = map { $_->name } @{$release_info->modules};
my $perms_test = Test::PAUSE::ConsistentPermissions::Check->new;
my $problems = $perms_test->report_problems(\@modules, 'OpusVL::AppKit');
eq_or_diff $problems, { 
    module => 'OpusVL::AppKit',
    owner => 'NEWELLC',
    comaint => [qw/ALTREUS BRADH JONALLEN NMBOOKER/],
    problems => [
    ],
};

done_testing;

