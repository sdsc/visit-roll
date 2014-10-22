#!/usr/bin/perl -w
# visit roll installation test.  Usage:
# visit.t [nodetype]
#   where nodetype is one of "Compute", "Dbnode", "Frontend" or "Login"
#   if not specified, the test assumes either Compute or Frontend

use Test::More qw(no_plan);

my $appliance = $#ARGV >= 0 ? $ARGV[0] :
                -d '/export/rocks/install' ? 'Frontend' : 'Compute';
my $installedOnAppliancesPattern = '.';
my $isInstalled = -d '/opt/visit';
my $output;

# visit-common.xml
if($appliance =~ /$installedOnAppliancesPattern/) {
  ok($isInstalled, 'visit installed');
} else {
  ok(! $isInstalled, 'visit not installed');
}
SKIP: {

  skip 'visit not installed', 4 if ! $isInstalled;
  # The graphical nature of visit limits the testing we can do
  $output = `/opt/visit/bin/visit -version 2>&1`;
  like($output, qr/The current version of VisIt is/, 'visit exec works');

  skip 'modules not installed', 3 if ! -f '/etc/profile.d/modules.sh';
  `/bin/ls /opt/modulefiles/applications/visit/[0-9]* 2>&1`;
  ok($? == 0, 'visit module installed');
  `/bin/ls /opt/modulefiles/applications/visit/.version.[0-9]* 2>&1`;
  ok($? == 0, 'visit version module installed');
  ok(-l '/opt/modulefiles/applications/visit/.version',
     'visit version module link created');

}
