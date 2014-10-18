#!/usr/bin/perl

use strict;
use warnings;

use Getopt::Long;
use Const::Fast;
use Carp;
use Data::Dumper;

const my $MERGE_SORT                => 'merge_sort';
const my $DEFAULT_IMPLEMENTATION    => $MERGE_SORT;
const my %ALL_IMPLEMENTATIONS       => (
	$MERGE_SORT     => 1,
);

my $type   	= $DEFAULT_IMPLEMENTATION;
my $help	= 0;
my @array   = (5,4,3,2,8,11,80,6789,2,1);

GetOptions(
    'type=s'   => \$type,
    'help!'    => \$help,
) or die("Error in command line arguments\n");

croak "Undefined implementation type '$type'. Check help text for more info!\n" if(! exists $ALL_IMPLEMENTATIONS{$type});

if($help) {
	print "Help Text!\n";
} elsif ($type = $MERGE_SORT) {
    print Dumper [merge_sort(@array)];
}

sub merge_sort {
    my (@array) = @_;

    use integer;

    my $size = scalar @array;
    my $half = $size/2;

    if($size == 1) {
        return $array[0];
    } else {
        return merge([merge_sort(@array[0..$half-1])],[merge_sort(@array[$half..$size-1])]);
    }
}

sub merge {
    my ($array1,$array2) = @_;

    my @return = ();
    my @array1 = @{$array1};
    my @array2 = @{$array2};


    foreach (0..(scalar @{$array1} + scalar @{$array2})) {
        if(scalar @array2 || scalar @array1) {
            if(!(scalar @array2) || (scalar @array1 && ($array1[0] <= $array2[0]))) {
                push(@return, shift @array1);
            } elsif(scalar @array2) {
                push(@return, shift @array2);
            }
        }
    }

    return @return;
}

