sub process_args(*@input) {
    @input.antipairs.map(-> $pairs { 
        given $pairs.key {
            when 'i' {
                die "Must be longer than 1" unless @input[$pairs.value+1].chars > 1;
                &input( @input[$pairs.value + 1]  );
            }
            when 'd' {
                die "Must be an integer";
            }
        }
    });
}

sub input( $key ) {
    say $key;
}

sub MAIN(*@input) {
    process_args(@input);
}

