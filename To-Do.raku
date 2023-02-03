sub process_args(*@input) {
    @input.antipairs.map({ given *.key {
         when 'i' {
             die "Must be longer than 1" unless @input[*.value].chars > 1;
             &input( *.value+1  );
         }
         default {
             say "Unknown";
         }
     }});
}

sub input( $key ) {
    say $key;
}

sub MAIN(*@input) {
    process_args(@input);
}

