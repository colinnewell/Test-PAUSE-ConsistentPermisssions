# Test-PAUSE-ConsistentPermisssions

Checking your PAUSE permissions are consistent for a module.

This module provides methods for testing permissions manually
with a script, and a testing method.

    script/pause-check-distro-perms

For tests,

```
use Test::Most;
use Test::PAUSE::ConsistentPermissions;

all_permissions_consistent 'Test::PAUSE::ConsistentPermissions';

```


## Installation

Note, not currently on CPAN.  This will be how you install it once
it is.

    cpanm Test::PAUSE::ConsistentPermissions

## Development

See CONTRIBUTING.md for details on contributing to the project.

