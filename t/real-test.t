use Test::Most;
use Test::PAUSE::ConsistentPermissions::Check;

BEGIN {
    plan skip_all => 'Set LIVE_TEST environmental variable to test this.' unless $ENV{LIVE_TEST};
}
# NOTE: this test is very likely to fail as it's checking the state of cpan itself.

# FIXME: make sure this is optional.
use PAUSE::Packages;
my $pp = PAUSE::Packages->new;
my $perms_test = Test::PAUSE::ConsistentPermissions::Check->new;

sub check_package
{
    my $dist = shift;
    my $module = shift;
    my $release_info = $pp->release($dist);
    my @modules = map { $_->name } @{$release_info->modules};
    my $problems = $perms_test->report_problems(\@modules, $module);
}

# FIXME: make use of local file.
# then we don't need the guff (perhaps)
eq_or_diff check_package('OpusVL-AppKit', 'OpusVL::AppKit'), {
    module => 'OpusVL::AppKit',
    owner => 'NEWELLC',
    comaint => [qw/ALTREUS BRADH JONALLEN NMBOOKER/],
    problems => [
    ],
};
eq_or_diff check_package('Test-DBIx-Class', 'Test::DBIx::Class'), {
    module => 'Test::DBIx::Class',
    owner => 'JJNAPIORK',
    comaint => [qw/NEWELLC PHAYLON/],
    problems => [
    ],
};
eq_or_diff check_package('DBIx-Class-Migration', 'DBIx::Class::Migration'), {
    module => 'DBIx::Class::Migration',
    owner => 'JJNAPIORK',
    comaint => [qw/PNU SKAUFMAN/],
    problems => [
        {
            module => 'DBIx::Class::Migration::SandboxDirSandboxBuilder',
            issues => {
                missing => ['PNU', 'SKAUFMAN'],
            },
        },
        {
            module => 'Test::DBIx::Class::FixtureCommand::Population',
            issues => {
                extra => ['NEWELLC']
            },
        },
    ],
};

done_testing;

