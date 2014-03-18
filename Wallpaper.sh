#!/bin/bash
# this script changes the backgrounds on the desktop

SCREEN_CHANGE='pcmanfm -w'
PICTURE_DIR='.user-cache/Pictures/'

lock="/var/lock/.wallpaper.lock"

if [[ $# -gt 0 ]]; then
	if [[ ("$1" == "-u" || "$1" == "-n") && -f $lock ]]; then
		pidd=$(cat $lock)
		if [[ "$1" == "-u" ]]; then
			kill -SIGUSR1 $pidd
			echo "Updating image list on Wallpaper Daemon"
			exit 0
		elif [[ "$1" == "-n" ]]; then
			kill -SIGUSR2 $pidd
			echo "Changing picture on Wallpaper Daemon"
			exit 0
		fi
		echo "No wallpaper changing thread to update"
		exit 1
	fi
	dir=$1
else
	dir="${HOME}/${PICTURE_DIR}"
fi

if [[ -f $lock ]]; then
	echo "Can't start new wallpaper changing thread"
	exit 1
else
	echo $$ > $lock
fi

trap removeFilesAndExit SIGTERM SIGINT EXIT
trap updateFiles SIGUSR1
trap nextPic SIGUSR2

tmp=`tempfile`

function updateFiles {
	find $dir -type f > $tmp
	echo "Updating picture files"
}

function removeFilesAndExit {
	if [[ -f $tmp ]]; then
		rm $tmp
	fi
	if [[ -f $lock && "$(cat $lock)" -eq $$ ]]; then
		rm $lock
	fi
	exit 0
}

function nextPic {
	new=`shuf $tmp -n1`
	$SCREEN_CHANGE "${new}"
	tmp2=`tempfile`
	ffmpeg -i $new 2> $tmp2
	tmp3=$(cat $tmp2 | grep Stream | grep -Eo '[0-9]{3,5}x[0-9]{3,5}')
	rm $tmp2
	echo $? $tmp3 $new
	count=0
}

updateFiles

#set the change picture delay to 5 minutes
#wait in 60 second increments
#set the initial counter to 0
delay=300
incr=60
count=0

while true ; do
	nextPic
	while [[ $count -lt $delay ]]; do
		sleep $incr
		count=$(($count+$incr))
	done
done
