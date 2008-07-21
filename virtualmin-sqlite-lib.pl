# Functions for the SQLite database

do '../web-lib.pl';
&init_config();
do '../ui-lib.pl';

sub databases_in_dir
{
local @rv;
opendir(DIR, $_[0]);
while(my $f = readdir(DIR)) {
	if ($f =~ /^(\S+)\.sqlite$/) {
		push(@rv, { 'name' => $1,
			    'type' => $module_name,
			    'file' => "$_[0]/$f",
			    'desc' => $text{'db_name'} });
		}
	}
closedir(DIR);
return @rv;
}

# get_sqlite_command()
# Returns the command for sqlite, favouring sqlite and then falling back to
# sqlite2 and 3. Returns undef if none was found.
sub get_sqlite_command
{
foreach my $c ("sqlite", "sqlite4", "sqlite3", "sqlite2", "sqlite1") {
	local $p = &has_command($c);
	return $p if ($p);
	}
return undef;
}

1;

