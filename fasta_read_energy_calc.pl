#!/usr/bin/perl

# Create a program that reads DNA sequences in FASTA format and calculates
# free energy of sequence duplex formation of the given
# and its complementary sequence
# according to the SantaLucia algorithm with unified parameters.

use warnings;
use strict;

my %DNA = ('A' => 'T', 'C' => 'G', 'T' => 'A', 'G' => 'C');
my %numbers = ('AA' => -1.00, 'AT' => -0.88, 'TA' => -0.58,
				'CA' => -1.45, 'GT' => -1.44, 'CT' => -1.28,
				'GA' => -1.3, 'CG' => -2.17, 'GC' => -2.24,
				'GG' => -1.84);
my %init = ('T' => 1.03, 'A' => 1.03, 'G' => 0.98, 'C' => 0.98);

my $totalG = 0;
local $/ = '>';

# Reading the file
while(my $line = <>) {
	chomp($line);
	if($line){
		my($header, $sequence) = split /\n/, $line, 2;
		if($sequence){
			my $fixedSequence='';
			# Making sequence upper-cased
			$sequence = uc($sequence);
			my $complementary = "";
			# Checking if the sequence contains spaces and removes them,
			# create complementary sequence
			for(my $i = 0; $i < length($sequence); $i++){
				if((substr $sequence, $i, 1) ne " " && 
				(substr $sequence, $i, 1) ne "\n"){
					$fixedSequence = $fixedSequence .
					substr $sequence, $i, 1;
					$complementary = $complementary .
					$DNA{substr $sequence, $i, 1};
				}
				else{
					next;
				}
			}
			if($fixedSequence ne ''){
				if($fixedSequence eq reverse $complementary){
					$totalG += 0.43;
				}
				$totalG = $totalG 
				+ $init{substr $fixedSequence, 0, 1}
				+ $init{substr $fixedSequence, length($fixedSequence) - 1, 1};
				for(my $i = 0; $i < length($fixedSequence) - 1; $i++){
					if(exists $numbers{substr $fixedSequence, $i, 2}){
						$totalG += $numbers{substr $fixedSequence, $i, 2};
					}
					else{
						$totalG += $numbers{
						reverse(substr($complementary, $i, 2))};
					}
				}
			}
		}
		print">$header";
		if($totalG != 0){
			printf(" %.2f\n",$totalG);
		} else{
			printf(" %.0f\n",$totalG);
		}
	}
	$totalG = 0;
}
