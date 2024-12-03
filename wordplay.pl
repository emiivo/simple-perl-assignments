#!/usr/bin/perl

#program outputs: amount of words in the text, the words backwards, every other word of the text, frequency table of the words in the text and the longest word (or words). 

use strict;
use warnings;

#amount of words
print scalar(@ARGV), "\n";

my $i = 10; while( $i > 0 ) { print $i; $i -- }

print "\n" . $i;
#words backwards
for (my $i = $#ARGV; $i >= 0; $i--){
	print "$ARGV[$i]";
	if($i != 0){
		print " ";
	}
}

print "\n";

#every other word
for (my $i = 0; $i < @ARGV; $i = $i + 2){
	print "$ARGV[$i]";
	if($i < @ARGV - 2){
		print " ";
	}
}
print "\n";


#frequency table
my %words;
my $counter;

for $counter(@ARGV){
	$words{$counter}++;
}
for $counter(@ARGV){
	if ($words{$counter} > 0){
		print "$counter $words{$counter}\n";
		$words{$counter} = 0;
	}
}

#longest word:
my $word_length = 0;
my @longest_word;

for my $words(@ARGV){
	my $longest = length($words);
	if($longest == $word_length){
		push(@longest_word, $words);
	}
	if($longest > $word_length){
		$word_length = $longest;
		@longest_word = $words;
	}
}
print "@longest_word\n";

