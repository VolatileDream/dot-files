#!/bin/bash

hash='md5sum';
dir='';
verbose=0;

#insert usage + command line parsing

if [[ $# -lt 1 ]]; then

	echo "Usage: $0 [-h hashprogram] [-v] directory";
	exit 0 ;
fi;

while [[ $# -gt 0 ]]; do

	if [[ "$1" = "-h" ]];	then
		hash=$2;
		shift;
	elif [[ "$1" = "-v" ]]; then
		verbose=1;
	else
		dir="$1";
	fi
	shift
done

if [[ -z "${dir}" ]]; then
	echo "No directory set."
	exit 1;
fi

options="-i"
if [[ $verbose -gt 0 ]]; then
	options="${options}v"
fi

file=$(mktemp)

find ${dir} -type f > ${file}

#loop through all the files
while read line ; do

	i=0;

	hashout=`${hash} "$line"` ;
	#remove file path
	ext=${hashout##*/} ;

	#remove everything up to the first .
	ext=${ext#*.} ;

	name=${hashout%% *} ;

	newname="${name}.${ext}" ;

	while [[ -e "$newname" ]]; do
		newname="${name}.${i}.${ext}";	
		i=$((i+1));
	done ;

	#use -i to catch race condition...
	mv ${options} "$line" "$newname"
	
done < $file;

rm $file;
