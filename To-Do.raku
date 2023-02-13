use Slang::SQL;
use DBIish;

my $*db = DBIish.connect("SQLite", :database<ToDo.db>);

my @thing;

sub process_args(*@input) {
    @input.antipairs.map(-> $pairs { 
        my $next = @input[$pairs.value+1];
        given $pairs.key {
            when 'i' {
                die "Must be longer than 1" unless $next.chars > 1;
                &input( @input[$pairs.value + 1]  );
            }
            when 'd' {
                $next.Int  ?? &delete($next) !! die "Must be an int";
            }
            when 'p' {
                &print();
            }

        }
    });
}

sub delete( $index ) {
    @thing.splice($index-1, 1);
}

sub input( $item ) {
    @thing.push($item)
}

sub move ( $old, $new){
    my $item = @thing[$old];
    &delete($old);
    &input($new, $item);
} 
sub print(){
    @thing.antipairs.map(-> $item {
        my $index = $item.value + 1;
        my $val = $item.key;
        say "[$index]\t$val";
    });
}

sub MAIN(*@input) {
    process_args(@input);
    &print();
}

