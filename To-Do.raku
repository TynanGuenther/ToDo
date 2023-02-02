sub main() {
    say 
}
sub *ARGS-TO-CAPTURE(&main, @args --> Capture) {
    if '-i' ~~ any @ARGS {
        my $index = (@ARGS.grep({ /<[i]>/}, :kv))[0] + 1; 
        die "Item on list must me longer than 1 character!" unless @ARGS[$index].chars > 2;

    }
}
