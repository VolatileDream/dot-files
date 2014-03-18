#!/bin/bash

if [[ $# -lt 2 ]]; then
	echo "Usage: FolderSync.sh <mobile> <local>"
	echo "	This ensures that the newest files are in folder 1 and 2"
	echo "	this does not check if both files have been changed."
	echo "	requires a .sync file in mobile"
	exit 1
fi

#check if files are being added
if [[ "$1" = "-a" ]]; then
	echo "Setting up sync file with contents of '$2'"
	ls "$2" > "${2}/.sync"
	exit
fi

#mobile + local folders respectively
mob=""
loc="";
#figure out which folder has the file list of stuff we need to copy
if [[ -f "${1}/.sync" ]] ; then
	mob="${1}"
	loc="${2}"
elif [[ -f "${2}/.sync" ]] ; then
	mob="${2}"
	loc="${1}"
else
	echo "Couldn't find a '.sync' file please run this with '-a' to set up properly"
	exit 2;
fi


while read file ; do

	#copy into the mobile first, and then out

	if [[ -f "${loc}/${file}" ]] ; then
		cp -u "${loc}/${file}" "${mob}/${file}"
	fi
	if [[ -f "${mob}/${file}" ]] ; then
		cp -u "${mob}/${file}" "${loc}/${file}"
	fi
	if ! [[ -f "${mob}/${file}" && -f "${loc}/${file}" ]] ; then
		echo -e "\t${file} does not exist...\nMaybe you should update the .sync file."
	else
		echo "${file} updated succesfully"
	fi

done < "${mob}/.sync"
