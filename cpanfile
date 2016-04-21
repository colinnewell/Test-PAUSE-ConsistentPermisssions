requires 'List::Compare';
requires 'Moo';
requires 'Parse::LocalDistribution';
requires 'PAUSE::Packages';
requires 'PAUSE::Permissions';
requires 'strictures' => '2';

on 'test' => sub {
    requires 'Test::Most';
    requires 'Test::MockObject';
};
