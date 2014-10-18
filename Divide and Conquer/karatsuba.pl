#!/usr/bin/perl

use strict;
use warnings;

use Getopt::Long;
use Const::Fast;
use Carp;

const my $DEFAULT_IMPLEMENTATION 	=> 'default';
const my $DEFAULT_NUMS 				=> '0,0'; 
const my %ALL_IMPLEMENTATIONS 		=> (
	naive 		=> 1, 
	karatsuba 	=> 1,
	default 	=> 1,
);

my $type   	= $DEFAULT_IMPLEMENTATION;
my $help	= 0;
my $nums   	= $DEFAULT_NUMS;

GetOptions(
	'type=s'	=> \$type,
	'help!'    	=> \$help,
	'nums=s'	=> \$nums,
) or die("Error in command line arguments\n");

if($help) {
	print "Help Text!\n";
} else {

	my @nums = split(',',$nums);
	croak "Only enter two numbers!\n" if (scalar @nums > 2);
	
	croak "Undefined implementation type '$type'. Check help text for more info!\n" if(! exists $ALL_IMPLEMENTATIONS{$type});

	if($type == 'default') {
		print 'Multiplication Product = '.$num[0]*$num[1]."\n";
	} elsif($type == 'naive') {
		print 'Multiplication Product = '.(naive_mul(@nums))."\n";
	} else {
		print 'Multiplication Product = '.(karatsuba_mul(@nums))."\n";
	}
}

sub naive_mul {
	my ($num1,$num2) = @_;

	my @num1 = split('',$num1);
	my @num2 = split('',$num2);

	foreach my $i (@num2) {
		foreach my $j (@num1) {
			my $prod = basic_multiply($i,$j);
			my $
		}
	}
}

sub basic_multiply {
	my ($num1,$num2) = @_;

	for ($num1,$num2) {
		croak "$_ is not a basic multiplication operand\n" if($_ > 9 && $_ < 0);
	}

	return $num1*$num2;
}

sub basic_add {
	my ($num1,$num2) = @_;

	for ($num1,$num2) {
		croak "$_ is not a basic addition operand\n" if($_ > 9 && $_ < 0);
	}

	return $num1+$num2;
}

exit(0); 
