#!/usr/bin/perl

# Create a program that searches for patterns in DNA
# sequences provided in FASTA format files.
# Identify the cut locations in each of the FASTA sequences.

use warnings;
use strict;


if(@ARGV == 0){
	print "Provide arguments for program - where to split and FASTA file.\n";
	print "Example of request: perl Emilija_Ivoškaitė.pl ACM/NBNC file.fasta\n";
	exit;
}

my $whatToCut = shift(@ARGV);
my $realCut = '';
my $cutPosition = 0;
my %wildcard = ('R' => '(A|G)', 'Y' => '(C|T)', 'K' => '(G|T)', 
		'M' => '(A|C)', 'S' => '(C|G)', 'W' => '(A|T)', 
		'B' => '(C|G|T)', 'D' => '(A|G|T)', 'H' => '(A|C|T)',
		'V' => '(A|C|G)', 'N' => '(A|C|G|T)');

# Takes cutting sequence, finds at which index to cut and
# finds meanings of the wildcards.

for(my $i = 0; $i < length($whatToCut); $i++){
	if(substr($whatToCut, $i, 1) eq '/'){
		$cutPosition = $i;
		next;
	}
	if($wildcard{substr $whatToCut, $i, 1}){
		$realCut .= $wildcard{substr $whatToCut, $i, 1};
	}
	else{
		$realCut .= substr $whatToCut, $i, 1;
	}
}

local $/ = '>';

while(my $record = <>) {
	chomp($record);
	
	# Splits FASTA file by '>' symbol.
	my ($header, @lines) = split /\n/, $record;
	my $sequence = join '', @lines;

	# Finds if sequence is the same as cutting sequence.
	if($sequence =~ /$realCut/){
		my @products;
		my $previousPos = 0;
		
		# Finds all places where sequence is the same as cutting sequence.
		# Finds where the cuts occur.
		while($sequence =~ /$realCut/g){
			my $cutLocation = $-[0] + $cutPosition;
			my $product = substr($sequence, $previousPos,
								$-[0] - $previousPos + $cutPosition);
			push @products, [$cutLocation, $product];
			$previousPos = $-[0] + $cutPosition;
		}
		
		push @products, [$cutPosition, substr($sequence, $previousPos)];
        
        
       	# Outputs cut sequences.
		for (my $i = 0; $i <= $#products; $i++){
			my ($cutLocation, $sequence) = @{$products[$i]};
				if ($i < $#products) {
					print(">" . $header . " $cutLocation\n");
				}
				else {
					print(">" . $header . "\n");
				}
				while (length $sequence > 0) {
					my $line = substr($sequence, 0, 80, "");
					print $line . "\n";
				}
		}
	}
}

