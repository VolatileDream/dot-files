#!/usr/bin/perl
use strict;
use warnings;
use Cwd ; # use cwd(), getcwd(), fastcwd(), fastgetcwd()
use IO::File;

if ( $#ARGV+1 < 1 ){
	print "usage:\n\t$0 <file>\n";
	print "\tfile: a .h or .cpp file\n";
	exit 1;
}else{
	my $dir = getcwd();
	for( @ARGV ) {
		$_ =~ /((.+?\/)+|)(.+?).(h|cpp)$/;
		my $locdir = $1;
		my $r_name = $3;
		my $name = uc($3);
		my $ext = $4;
		unless (-e $_ ){
			my $fh = new IO::File("> ${dir}/$_");
			if ( ! $fh ){
				print "Error: can't generate $_\n";
				next;
			}
			if ( "$ext" eq "h" ) {
				#we generate the .h file
				print $fh "#pragma once\n#ifndef ${name}_H\n#define $name 1\n\n#endif /* ${name}_H */\n";
			} elsif ( "$ext" eq "cpp" ) {
				#generate a .cpp file
				print $fh "#include \<stdlib.h\>\n#include \"${3}.h\"\n\nnamespace $r_name {\n\t\n\t\n\t\n};\n";
			}
			$fh->close;
			print "Generated: $_\n";
		} else {
			print "Error: $_ exists.\n";
		}
	}
}

