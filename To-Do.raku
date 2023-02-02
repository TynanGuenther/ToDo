#sub main() {
#    say 
#}
#sub *ARGS-TO-CAPTURE(&main, @args --> Capture) {
#    if '-i' ~~ any @ARGS {
#        my $index = (@ARGS.grep({ /<[i]>/}, :kv))[0] + 1; 
#        die "Item on list must me longer than 1 character!" unless @ARGS[$index].chars > 2;
#
#
#    }
#}

sub MAIN(*@input) {
    say @input;
}

sub ARGS-TO-CAPTURE(&main, @args --> Capture) {
    # if we only specified "frobnicate" as an argument 
    my @todo;
    if @args > 1 && "-i" ~~ any @args {
      # then dispatch as MAIN("foo","bar",verbose => 2) 
      my $index = (@args.grep({ /<[i]>/}, :kv))[0] + 1; 
      die "Item on list must be longer than 1 character!" unless @args[$index].chars > 2;
      @todo.push(@args[$index]);
      Capture.new(@todo);
  }
  else {    # otherwise, use default processing of args 
      &*ARGS-TO-CAPTURE(&main, @args)
  }
}
