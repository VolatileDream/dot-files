#!/bin/bash

if [ $# -lt 1 ]; then
	echo "Usage: [-(s|l)] [dir]+"
	echo " [dir] directory of music to play"
	echo " [-s] play shuffled, otherwise this plays in alphabetical order."
	echo " [-l] loop, otherwise plays through all the songs once"
	echo " default audio types are: mp3, avi, flac, ogg, mp4, aac, wma"
	exit 1
fi
#declare variables

tmp_template="PlayMusic.XXXXXXX"
# nicely name the temporary file we create
file=`mktemp --tmpdir=/tmp $tmp_template`
parameters=""

while [ $# -gt 0 ] ; do
	arg=$1
	if [ "$arg" = "-l" ]; then
		parameters="${parameters} -loop 0"
	elif [ "$arg" = "-s" ]; then
		parameters="${parameters} -shuffle"
	elif [ -e "$arg" ]; then
		if [[ -d "$arg" && -L "$arg" && "${arg%/}" == "$arg" ]]; then
			# it's a symbolic link, make sure it ends with a /
			arg="$arg/"
		fi
		find "$arg" -type f -print | grep -E "\.(wav|mp3|avi|flac|ogg|mp4|aac|wma)$" | sort -u >> ${file}
	else
		echo "Unrecognized option ${arg}"
	fi
	shift
done

path=$( pwd | sed 's_&_\\&_' )

# we don't care how f2 is named, we don't keep it very long...
f2=`mktemp`
#make the files have abs path if they already don't, and escape spaces
cat ${file} | sed "s_^\./_${path}/_" | sed -r "s_^([^/])_${path}/\1_" | sed 's_ _\ _g' | sort -u > ${f2}
mv ${f2} ${file}

echo $parameters -playlist ${file}
mplayer $parameters -playlist ${file}

rm ${file}
exit
