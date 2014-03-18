#!/usr/bin/perl
use strict;
use warnings;

sub ren;
sub pad;

sub ren {
	my ($string, $incr, $pad) = @_;
	# string = the string we want to increment numbers in
	# pad = the number of spaces we want to pad the numbers to
	# incr = the number we want to increment the numbers in $string by

	my @words = ($string =~ /([^\d]*)(\d+)/g);
	my $return = "";
	for( @words ){
		if ( $_ =~ /^[+-]?\d+$/ ){
			$return .= pad($_ + $incr, $pad) ;
		} else {
			$return .= $_;
		}
	}
	$string =~ /([^\d]+)$/ ; # match the last non digit part of the string
	return "${return}$1";
}

sub pad {
	my ($var, $pad) = @_;
	while ( length($var) < $pad ){
		$var = "0$var";
	}
	return $var;
}

#print( ren("airgear_127_ab_002-003.png", 4, 3) . "\n" );
if( $#ARGV+1 < 1 ){
	print "Not enough parameters\n\tDir\n\tIncrement\t\t[default 0]\n\tZero Padding\t\t[default 3]\n\tMatch Regex\t\t[default .]\n";
	exit 1;
}
my ($dir, $inc, $pad, $reg) = @ARGV; # set the variables.
#if not initialized set defaults
if( not $inc ) {
	$inc = 0;
}
if( not $pad ) {
	$pad = 3;
}
if( not $reg ){
	$reg = ".";
}

my @f = < ${dir}/* >;
my $name = "";
for( @f ){
	if( $_ =~ $reg ){
		$_ =~ /^(.*\/)(.+)/;
		$name = "$1" . ren( $2, $inc, $pad);
		print( "$_ -> $name\n" );
		rename( $_ , $name) or print("Couldn't rename $_\n");
	}
}
