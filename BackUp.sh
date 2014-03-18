#!/bin/bash

if [[ $# -lt 1 ]]; then
	echo "Usage: <directory> <name> [-encrypt recipient] [-o]"
	echo "<directory>		the directory to save (saves all contents too)"
	echo "<name>			file name to use for archive, all files are named: date_name.7z"
	echo "-o			overwrite files that already exist"
	echo "[-encrypt recipient]	this encrypts the .7z file created and sets the recipient(s) to 'recipient'"
	exit
fi

file=$1
shift
name=$1
shift
over="no"
if [[ "$1" -eq "-o" ]]; then
	over="yes"
	shift
fi
recipients=$@
echo $recipients

time=`date +%Y_%m_%e`
7z a -r ~/Back\ Up/${time}_${name}.7z $file
if [[ "$recipients" -ne ""]]; then
	gpg --default-recipient $recipients --encrypt-files ~/Journal\ Back\ Up/${time}_${name}.7z
	rm ~/Back\ Up/${time}_${name}.7z
fi
echo "Saved to: ${time}"'

