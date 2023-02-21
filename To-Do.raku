
use JSON::Fast;


my $file = "todo.json";

sub process_args(*@input) {
    @input.antipairs.map(-> $pairs { 
        my $next = @input[$pairs.value+1];
        given $pairs.key {
            when 'i' {
                die "Must be longer than 1" unless $next.chars > 1;
                &input( @input[$pairs.value + 1]  );
            }
            when 'd' {
                $next.Int ?? &delete($next) !! die "Must be an int greater than 0";
            }
            when 'p' {
                &print();
            }

        }
    });
}

sub delete( $index ) {
    my @input = from-json($file.IO.slurp);
    if @input.elems >= $index {
        @input.splice($index - 1, 1);
    }
    spurt $file, (to-json @input);
}

sub input( $item ) {
    if $file.IO.s { 
        my @l = (from-json $file.IO.slurp);
        my $count = @l.elems + 1;
        my Pair $par = $count => $item;
        @l.append: $item;
        spurt $file, (to-json @l);
    }
    else {
        say "Creating New File";
        my Pair $par = 1 => $item;
        my @l;
        @l.append: $item;
        spurt $file, (to-json @l);
    }
}

sub print(){
    die "To-Do list is empty!!" unless $file.IO.s;
    my @l = (from-json $file.IO.slurp);
    say "\n\t\e[1m\e[4mToDo\e[0m\e[0m";
    @l.pairs.map(-> $thing {
        my $index = $thing.key + 1;
        my $val = $thing.value;
        say "[$index]\t$val";
    });
    say "\n";

}

sub MAIN(*@input) {
    process_args(@input);
}

