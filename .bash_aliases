
# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# command aliases
ndir(){
    if [[ $# -eq 0 ]]; then
        echo "Usage: $0 [dirs ...] last-dir"
        echo " creates dirs, then creates and enters last-dir"
        echo " uses -p on mkdir, so parents are implicitly created"
        return
    fi

    for dir in $@ ; do
        mkdir -p "$dir"
        last="$dir"
    done

    cd "$last"
}
alias lsall='lshal ; lshw ; lspci ; lsusb'
alias jar='java -jar'
alias tail='tail -f'
alias g='grep -E'
alias sw='sudo iwlist scan'
alias list='find . | grep -E'
alias count='ls | wc -l'

if [[ -n $(which xdg-open) ]]; then
	alias open='xdg-open'
fi

if [[ -n $(which sshfs) ]];then
	function ssh-mount(){
		if [[ $# -lt 3 ]]; then
			echo "Usage: ssh-mount host remote-dir local-dir";
			exit;
		fi
		sshfs ${1}:${2} ${3}
	}
	function ssh-umount(){
		fusermount -u ${1}
	}
fi

# keyboard commands
alias asdf='setxkbmap dvorak'
alias aoeu='setxkbmap us'


alias bkj='time=`date +%Y_%m_%d` ; 7z a -r ~/Documents/${time}_Journal.7z /media/jex/simulacrum/* ; gpg --default-recipient jex --encrypt-files ~/Journal\ Back\ Up/${time}_Journal.7z ; shred --remove --zero --iterations 17 ~/Documents/${time}_Journal.7z ; echo "Saved to: ${time}"'

alias com='
	rm ~/.cache/dmenu_{cache,out} ;
	for p in ${PATH//:/" "} ; do
		find $p -maxdepth 1 -type f -executable -printf "%f\n" >> ~/.cache/dmenu_cache ;
	done ;
	dmenu -i -b -p \> < ~/.cache/dmenu_cache > ~/.cache/dmenu_out ;
	$(cat ~/.cache/dmenu_out) &'

# nav aliases
alias .=ls
alias .a='ls -a'
alias .l='ls -l'
alias .d='ls -al | grep drw'
alias ..='cd ..'

# custom command aliases
alias mcheck='ffmpeg -i'

alias randnum='cat /dev/urandom | g -Eo --binary-files=text "[0-9]"'

alias jsync='cp -vu --preserve=timestamps ~/.bash_aliases /media/Giannis\ Key/sync/ ; cp -vu --preserve=timestamps /media/Giannis\ Key/sync/.bash_aliases ~/.bash_aliases'

# Commands used for journal
date=`date +%Y_%m_%d`
alias rec='arecord'
alias play='aplay'
alias alog='arecord $date ; cp $date /media/Giannis\ Key/Journal/Audio\ Log/ ; shred -u $date'

# variables 
# SSH hosts
if [[ $(cat /etc/hostname) -eq "Po" ]] ; then
	PC='jex@null-pointer.local'
else
	PC='jex@Po.local'
fi
CS='glgambet@taurine.csclub.uwaterloo.ca'
UW='glgambet@linux.student.cs.uwaterloo.ca'

#temporary variables
