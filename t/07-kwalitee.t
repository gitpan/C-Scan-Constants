# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should
# work as `perl 07-kwalitee.t'

#########################


use Test::More;

# Only apply kwalitee tests if we are able to, otherwise apply tests.
eval { require Test::Kwalitee; Test::Kwalitee->import() };
plan( skip_all => 'Test::Wkalitee not installed; skipping' ) if $@;

