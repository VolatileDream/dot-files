#!/bin/sh
#this programs copies a movie from location A to location B, and then plays it using vlc
#this is so that movies with high quality can be played with out playback issues instead of running them off of an external drive


if [[ $# < 2 ]]; then
	echo "usage: VideoSync.sh <dirA> <dirB>"
fi

cp $1 $2 &
vlc $2
