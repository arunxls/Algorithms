#!/usr/bin/perl

use strict;
use warnings;

use Data::Dumper;
use Math::Complex;
use List::Util qw(min);

# Each node is represented as an arrayRef [x-coordinate, y-coordinate]
my $nodes = [[0, 0], [1, 0], [2, 0], [2.1, 0], [3, 0], [4, 0]];

my ($distance,$pair) = find_closest_pair($nodes);

print "The closest pair is ".Dumper($pair)." and has a distance of $distance\n";

sub find_closest_pair {
    my $nodes = shift;

    my $sorted_x = [sort sort_x @{$nodes}];
    my $sorted_y = [sort sort_y @{$nodes}];

    my ($dist_left,$left_pair)      = closest_pair($sorted_x);
    my ($dist_right,$right_pair)    = closest_pair($sorted_x);

    my ($pair,$distance);
    if($dist_left <= $dist_right) {
        $distance   = $dist_left;
        $pair       = $left_pair;
    } else {
        $distance   = $dist_right;
        $pair       = $right_pair;
    }

    return closest_split($sorted_y,$distance,$pair);
}

sub closest_split {
    my ($nodes,$delta,$best_pair) = @_;

    my $X           = $nodes->[int((scalar @{$nodes})/2)]->[0];
    my $distance    = $delta;
    my $pair        = $best_pair;

    foreach my $i (0..$#{$nodes}) {
        next if(!(($X - $delta) < ($nodes->[$i]->[0]) && (($nodes->[$i]->[0]) < $X + $delta)));
        foreach my $j (1..min(7,($#{$nodes}-$i))) {
            my $test_pair = [$nodes->[$i],$nodes->[$i+$j]];
            my $dist = distance($test_pair);
            if( $dist < $delta ) {
               $pair        = $test_pair;
               $distance    = $dist;
            }
        }
    }

    return ($distance,$pair);
}

sub closest_pair {
    my ($nodes,$sorted_x,$sorted_y) = @_;

    my $size = scalar @{$nodes};
    my $half = int($size/2);

    if($size == 2 ) {
        return $nodes;
    } elsif ($size == 3) {
        my $dist_left  = distance([@{$nodes}[0,1]]);
        my $dist_right = distance([@{$nodes}[1,2]]);

        if($dist_left <= $dist_right) {
            return ($dist_left,[@{$nodes}[0,1]]);
        } else {
            return ($dist_right,[@{$nodes}[1,2]]);
        }
    }

    my $left_set   = closest_pair([@{$nodes}[0..$half-1]]);
    my $dist_left  = distance($left_set);

    my $right_set  = closest_pair([@{$nodes}[$half..$size-1]]);
    my $dist_right = distance($right_set);

    if($dist_left <= $dist_right) {
        return ($dist_left,$left_set);
    } else {
        return ($dist_right,$right_set);
    }
}

sub distance {
    my $nodes = shift;

    return sqrt(($nodes->[0]->[0] - $nodes->[1]->[0])**2 + ($nodes->[0]->[1] - $nodes->[1]->[1])**2);
}

sub sort_x {
    $a->[0] <=> $b->[0];
}

sub sort_y {
    $a->[1] <=> $b->[1];
}
