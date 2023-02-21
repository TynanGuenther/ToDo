
use JSON::Fast;


my @thing;
my $nam = "todo.json";
class Item {
    has $.index;
    has $.val;
}
#$nam.IO.f ?? my $file = open $nam, :w, :r !! $file = open $nam, :w; 
#my $file = open $nam, :w;

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
    my @input = from-json("todo.json".IO.slurp);
    if @input.elems >= $index {
        @input.splice($index - 1, 1);
    }
    spurt "todo.json", (to-json @input);
    #    $file.print(to-json @input);

}

sub input( $item ) {
    if "todo.json".IO.s { 
        my @l = (from-json "todo.json".IO.slurp);
        my $count = @l.elems + 1;
        my Pair $par = $count => $item;
        @l.append: $item;
        spurt "todo.json", (to-json @l);
    }
    else {
        say "Creating New File";
        my Pair $par = 1 => $item;
        my @l;
        @l.append: $item;
        spurt "todo.json", (to-json @l);
    }
}

sub move ( $old, $new){

    #my $item = @thing[$old];
    #&delete($old);
    #&input($new, $item);
} 
sub print(){
    die "To-Do list is empty!!" unless "todo.json".IO.s;
    my @l = (from-json "todo.json".IO.slurp);
    say "\n\t\e[1m\e[4mToDo\e[0m\e[0m";
    @l.pairs.map(-> $thing {
        my $index = $thing.key + 1;
        my $val = $thing.value;
        say "[$index]\t$val";
    });
        #for @l {
            #my $index = $_.keys;
            #my $val = $_.values;
            #say "[$index]\t$val";
            #}
    say "\n";

}

sub MAIN(*@input) {
    process_args(@input);
}

