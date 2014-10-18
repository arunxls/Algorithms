select(STDOUT); $| = 1; # DO NOT REMOVE

# Auto-generated code below aims at helping you parse
# the standard input according to the problem statement.

chomp($R = <STDIN>); # the length of the road before the gap.
chomp($G = <STDIN>); # the length of the gap.
chomp($L = <STDIN>); # the length of the landing platform.

my $jump = 0;
# game loop
while (1) {
    chomp($S = <STDIN>); # the motorbike's speed.
    chomp($X = <STDIN>); # the position on the road of the motorbike.

    # Write an action using print
    # To debug: print STDERR "Debug messages...\n";

    if($jump == 0) {
        # print "SPEED\n" # A single line containing one of 4 keywords: SPEED, SLOW, JUMP, WAIT.
        if($X + $S > $R) {
            print STDERR "Going to jump because $X + $S > $R; ";
            print STDERR "GAP $G SPEED $S LENGTH ROAD $R POSITION $X;";
            print "JUMP\n";
            $jump = 1;
        } else {
            print STDERR "Not going to jump because $X + $S <= $R; ";
            print STDERR "GAP $G SPEED $S LENGTH ROAD $R POSITION $X;";
            if($G >= $S) {
                print "SPEED\n";
            } elsif ($G = $S + 1) {
                print "WAIT\n";
            } else {
                if($S - $G > $G) {
                    print "SLOW\n";
                } else {
                    print "WAIT\n";
                }
            }
        }
    } else {
        print "SLOW\n";

    }
}

sub jump {
    my ($S, $X) = @_;
    # while(1) {
        debug_info($X,$S,$R,$G,$L);
        if($S >= (($R + $L + $G) - $X )) {
            print "WAIT\n";
        } else {
            print "SPEED\n";
        }
    # }
}

sub debug_info {
    foreach (@_) {
        print STDERR $_." ; ";
    }
}
