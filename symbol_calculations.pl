#!/usr/bin/perl

#Program outputs 1) all words starting with 'e' or 'E' in the first line;
#2) a symbol frequency table where the first column is the symbol
#(ordered from largest to smallest frequency.If frequency is the same,
#order is the ASCII number of symbol sorted from smallest to largest),
#second column is the freqency of the symbol,
#third column is the frequency ratio of the symbol.

use strict;
use warnings;


#find words starting with 'e' or 'E'

my @all_symbols;
my @words_from_e;


foreach my $word (@ARGV) {
	my @letters_from_word = split(//, $word);
	if (uc($letters_from_word[0]) eq 'E') {
		push @words_from_e, $word;
	}
	push(@all_symbols, @letters_from_word);
}

my $final_words = join(" ", @words_from_e);
print "$final_words\n";

my %freq;
my $total_symbols = 0;

#count symbols in the string
foreach my $symbol (@all_symbols) {
		$freq{$symbol}++;
		$total_symbols++;
}


#print frequency table
foreach my $symbol (
	sort { $freq{$b} <=> $freq{$a} or ord($a) <=> ord($b) } keys %freq) {
	my $count = $freq{$symbol};
	my $ratio = $count/$total_symbols;
	printf("%s %d %.2f\n", $symbol, $count, $ratio);
}
