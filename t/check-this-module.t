use Test::Most;
use Test::PAUSE::ConsistentPermissions;
use Test::MockObject;
my $mock = Test::MockObject->new();
my $mp = Test::MockObject->new();
$mp->set_always('owner', 'NEWELLC');
my @co_maint = qw/TEST1 TEST2/;
$mp->set_list('co_maintainers', @co_maint);
$mock->set_always('module_permissions', $mp);

my $perms_test = Test::PAUSE::ConsistentPermissions->new({ permissions_client => $mock });
my $problems = $perms_test->report_problems([qw/
OpusVL::AppKit
OpusVL::AppKit::Action::AppKitForm
OpusVL::AppKit::Builder
OpusVL::AppKit::Controller::AppKit
OpusVL::AppKit::Controller::AppKit::Admin
OpusVL::AppKit::Controller::AppKit::Admin::Access
OpusVL::AppKit::Controller::AppKit::Admin::Users
OpusVL::AppKit::Controller::AppKit::User
OpusVL::AppKit::Controller::Root
OpusVL::AppKit::Controller::Search
OpusVL::AppKit::FormFu::Constraint::AppKitPassword
OpusVL::AppKit::FormFu::Constraint::AppKitUsername
OpusVL::AppKit::Form::Login
OpusVL::AppKit::LDAPAuth
OpusVL::AppKit::Model::AppKitAuthDB
OpusVL::AppKit::Plugin::AppKit
OpusVL::AppKit::Plugin::AppKitControllerSorter
OpusVL::AppKit::Plugin::AppKit::FeatureList
OpusVL::AppKit::Plugin::AppKit::Node
OpusVL::AppKit::RolesFor::Auth
OpusVL::AppKit::RolesFor::Controller::GUI
OpusVL::AppKit::RolesFor::Model::LDAPAuth
OpusVL::AppKit::RolesFor::Plugin
OpusVL::AppKit::RolesFor::Schema::AppKitAuthDB
OpusVL::AppKit::RolesFor::Schema::AppKitAuthDB::Result::Aclrule
OpusVL::AppKit::RolesFor::Schema::AppKitAuthDB::Result::Parameter
OpusVL::AppKit::RolesFor::Schema::AppKitAuthDB::Result::Role
OpusVL::AppKit::RolesFor::Schema::AppKitAuthDB::Result::User
OpusVL::AppKit::RolesFor::Schema::DataInitialisation
OpusVL::AppKit::RolesFor::Schema::LDAPAuth
OpusVL::AppKit::RolesFor::UserSetupResultSet
OpusVL::AppKit::Schema::AppKitAuthDB
OpusVL::AppKit::Schema::AppKitAuthDB::Result::Aclfeature
OpusVL::AppKit::Schema::AppKitAuthDB::Result::AclfeatureRole
OpusVL::AppKit::Schema::AppKitAuthDB::Result::Aclrule
OpusVL::AppKit::Schema::AppKitAuthDB::Result::AclruleRole
OpusVL::AppKit::Schema::AppKitAuthDB::Result::Parameter
OpusVL::AppKit::Schema::AppKitAuthDB::Result::ParameterDefault
OpusVL::AppKit::Schema::AppKitAuthDB::Result::Role
OpusVL::AppKit::Schema::AppKitAuthDB::Result::RoleAdmin
OpusVL::AppKit::Schema::AppKitAuthDB::Result::RoleAllowed
OpusVL::AppKit::Schema::AppKitAuthDB::Result::User
OpusVL::AppKit::Schema::AppKitAuthDB::Result::UsersData
OpusVL::AppKit::Schema::AppKitAuthDB::Result::UsersParameter
OpusVL::AppKit::Schema::AppKitAuthDB::Result::UsersRole
OpusVL::AppKit::TraitFor::Controller::Login::NewSessionIdOnLogin
OpusVL::AppKit::TraitFor::Controller::Login::SetHomePageFlag
OpusVL::AppKit::View::AppKitTT
OpusVL::AppKit::View::Download
OpusVL::AppKit::View::DownloadFile
OpusVL::AppKit::View::Email
OpusVL::AppKit::View::Excel
OpusVL::AppKit::View::JSON
OpusVL::AppKit::View::PDF::Reuse
OpusVL::AppKit::View::SimpleXML
/], 'OpusVL::AppKit', {});
eq_or_diff $problems, { 
    comaint => \@co_maint,
    module => 'OpusVL::AppKit',
    owner => 'NEWELLC',
    problems => [],
}, 'OpusVL::AppKit should have no inconsistent permissions';

done_testing;
