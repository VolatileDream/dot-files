#!/usr/bin/env bash

# media command
m(){
    local options=()
    local inputs=()
    while [ $# -gt 0 ] ; do
        # seperate out options from inputs
        if [ -f "$1" ] || [ -d "$1" ]; then
            inputs[${#inputs[@]}]="$1"
        else
            options[${#options[@]}]="$1"
        fi
        shift
    done

    # need at least 1 input file/dir
    if [ ${#inputs[@]} -gt 0 ] ; then

        # create a playlist out of the files and dirs,
        # attempt to preserve order across inputs.

        local playlist=`mktemp`
        for index in ${!inputs[@]} ; do
            local in="${inputs[$index]}"
            if [ -f "$in" ]; then
                readlink -f "$in"
            else
                # find is almost sorted, but isn't required to be. We
                # assume that directories should be played in sorted
                # order when they are passed in.
                find "$(readlink -f "${in}")" -type f | sort
            fi
        done >> "$playlist"

        mpv "${options[@]}" --playlist "$playlist"
        rm "$playlist"
    else
        echo "m: input-file-or-dir <mpv options...>"
        return 1
    fi
}

if [ "$_" = "$0" ]; then
	# this file wasn't sourced, execute.
	m "$@"
	exit $?
fi
