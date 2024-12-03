#!/usr/bin/perl

#create a program that creates a circular linked list with pointers
#to the next and previous element. The code has special symbols "-" and "+",
#which move the pointer counterclockwise ("-") and clockwise ("+").

use strict;
use warnings;

#creates first element 0

my $first_number = {
	value => 0,
	prev => undef,
	next => undef
};

my $pointer = $first_number;

#makes a curcular linked list

$first_number->{prev} = $first_number;
$first_number->{next} = $first_number;

for(my $i = 0; $i < @ARGV; $i++)
{
	#if "-", move pointer one element back
	if($ARGV[$i] eq "-"){
		$pointer = $pointer->{prev};
	
	#if "+", move pointer one element forwards
	}elsif($ARGV[$i] eq "+"){
		$pointer = $pointer->{next};
		
	#if not "+" or "-", create new element and insert after $pointer
	}else{
		my $new = {
			value => $ARGV[$i],
			prev => $pointer,
			next => $pointer->{next}
		};
		
		$pointer->{next}->{prev} = $new;
		$pointer->{next} = $new;
		$pointer = $new;
		
	}
}


#print the list

print $first_number->{value};

while(my $value_now != $first_number;){
	$value_now = $first_number->{next};
	$value_now = $value_now->{next}){
	print " $value_now->{value}";
	}
}
	
print "\n";

