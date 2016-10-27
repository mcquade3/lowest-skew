#!/usr/local/bin/perl
# Mike McQuade
# lowest-skew.pl
# Takes in a string from an input file, then outputs
# the locations where the lowest skew occurs.

use strict;
use warnings;

# Define local variables
my ($genome,$currentSkew,$minSkew,@locations);
$currentSkew = $minSkew = 0;

# Open the file to read
open(my $fh,"<ba1f.txt") or die $!;

# Initialize genome variable with string in file
$genome = <$fh>;
chomp($genome);

# Iterate through the genome string
for (my $i = 0; $i < length($genome); $i++){
	if (substr($genome,$i,1) eq 'C') {# Decrease skew by 1
		$currentSkew--;
	} elsif (substr($genome,$i,1) eq 'G') {# Increase skew by 1
		$currentSkew++;
	}
	
	if ($currentSkew < $minSkew) {# The current skew is the new minimum
		@locations = $i+1;
		$minSkew = $currentSkew;
	} elsif ($currentSkew == $minSkew) {# The current location is added to the list
		push(@locations,$i+1);
	}
}

# Close the file
close($fh) || die "Couldn't close file properly";

# Define output string for locations found
my $output = "@locations\n";
chomp($output); # Remove whitespace after last number

# Print locations where the skew was minimized
print $output;