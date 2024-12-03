#!/usr/bin/perl

# Create a program that reads from files and prints
# multiplication of each line.
# If given --scalar option, the program outputs scalar multiplication.
# Print error if no files are specified, a file is not readable, 
# line amount in files differ or with option --scalar there
# are more or less than two files specified.

use strict;
use warnings;

my $scalar_mode = 0;

# Check if --scalar option is given
if (grep { $_ eq '--scalar' } @ARGV) {
	$scalar_mode = 1;
	@ARGV = grep { $_ ne '--scalar' } @ARGV;
}

# Check problems with amount and readability of input files
if (@ARGV < 1) {
	die "$0: no input files\n";
} else {
	foreach my $filename (@ARGV) {
	if (!-r $filename) {
		die "$0: $filename: cannot read file\n";
	}
	}
}

my $line_count;
my @file_contents;

# Read in file contents
foreach my $filename (@ARGV) {
	open(my $fh, '<', $filename) || die "$0:
						$filename: cannot read file\n";

	# <$fh> makes array of lines for file
	my @lines = <$fh>;
	close($fh);
	
	if (!defined $line_count) {
	$line_count = scalar @lines;
	} elsif ($line_count != scalar @lines) {
 		die "$0: $filename: number of lines differs from other files\n";
	}
	
	#Pushes a reference to an array with lines of the file to @file_contents.
	push @file_contents, \@lines;
}

my $scalar_product = 0;

my $file_contents;

# Multiply file contents
if ($scalar_mode) {
	if (@ARGV != 2) {
		die "$0: scalar mode requires two input files\n";
	}
	for (my $i = 0; $i < $line_count; $i++) {
    	my $file_1_number = $file_contents[0]->[$i];
    	my $file_2_number = $file_contents[1]->[$i];
    	$scalar_product += $file_1_number * $file_2_number;
}

	print "$scalar_product\n";
	
} else {
	for (my $i = 0; $i < $line_count; $i++) {
		my $non_scalar_answer = 1;
		foreach $file_contents (@file_contents) {
			my @numbers = $file_contents->[$i];
			foreach my $numbers_to_multiply (@numbers) {
				$non_scalar_answer *= $numbers_to_multiply;
			}
		}
	print "$non_scalar_answer\n";
	}
}
