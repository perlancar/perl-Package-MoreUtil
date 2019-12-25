#!perl

use 5.010;
use strict;
use warnings;
use Test::More;

use Package::MoreUtil qw(
                            package_exists
                            list_package_contents
                            list_package_subs
                            list_subpackages
                    );

BEGIN { ok(!package_exists("cps61kDkaNlLTrdXC91"), "package_exists 1"); }

package cps61kDkaNlLTrdXC91;

our $A = 1;
our @A = ();
our %A = ();
our $B = undef;
sub A  {}
#our *C;

package main;

# just test that we don't die
ok ( list_package_subs("main") );

ok( package_exists("cps61kDkaNlLTrdXC91"), "package_exists 1b");

package cps61kDkaNlLTrdXC92::cps61kDkaNlLTrdXC93;
package cps61kDkaNlLTrdXC92::cps61kDkaNlLTrdXC93::cps61kDkaNlLTrdXC94;
package main;

ok( package_exists("cps61kDkaNlLTrdXC92"), "package_exists 2");
ok( package_exists("cps61kDkaNlLTrdXC92::cps61kDkaNlLTrdXC93"),
    "package_exists 3");

my %res = list_package_contents("cps61kDkaNlLTrdXC91");
%res = map {$_ => ref($res{$_})} keys %res;
#diag explain \%res;
is_deeply(\%res,
          {
              '$A' => 'SCALAR',
              '%A' => 'HASH',
              '*B' => '',
              '@A' => 'ARRAY',
              'A' => 'CODE'
          },
          "list_package_contents 1"
      );

my @subnames = list_package_subs("cps61kDkaNlLTrdXC91");
is_deeply(\@subnames, ['A'],
          "list_package_subs"
      );

is_deeply([list_subpackages("cps61kDkaNlLTrdXC92")],
           ["cps61kDkaNlLTrdXC92::cps61kDkaNlLTrdXC93"],
           "list_subpackages 1");

is_deeply([list_subpackages("cps61kDkaNlLTrdXC92")],
           ["cps61kDkaNlLTrdXC92::cps61kDkaNlLTrdXC93"],
           "list_subpackages 1");
is_deeply([list_subpackages("cps61kDkaNlLTrdXC92", 1)],
           [
               "cps61kDkaNlLTrdXC92::cps61kDkaNlLTrdXC93",
               "cps61kDkaNlLTrdXC92::cps61kDkaNlLTrdXC93::cps61kDkaNlLTrdXC94",
           ],
           "list_subpackages 2");

DONE_TESTING:
done_testing();
