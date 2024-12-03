#!/usr/bin/perl


#Program outputs negative numbers as they are written
#and sorts positive numbers using bubble sort.


use strict;
use warnings;


my @non_negative_numbers;
my @negative_numbers;

#Positive or negative number
for (my $i = 0; $i < @ARGV; $i++){
	if ($ARGV[$i] >= 0){
        push @non_negative_numbers, $ARGV[$i];
	}
	else{
		push @negative_numbers, $ARGV[$i];
	}
}


#Bubble sort
my $is_swapped = 1;
while ($is_swapped){
	$is_swapped = 0;
	for (my $i = 0; $i < @non_negative_numbers - 1; $i++){
		if ($non_negative_numbers[$i] > $non_negative_numbers[$i+1]){
			($non_negative_numbers[$i], $non_negative_numbers[$i+1])= 
			($non_negative_numbers[$i+1], $non_negative_numbers[$i]);
			$is_swapped = 1;
		}
	}
}

print "@negative_numbers" . "\n";
print "@non_negative_numbers" . "\n";

