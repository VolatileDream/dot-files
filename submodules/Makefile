
all : tup chronos scry
.PHONY: tup chronos scry

tup : tup/tup
chronos : chronos/chronos
scry : inotify-tools/libinotify-tools/src/scry

tup/tup : 
	cd tup ; ./bootstrap.sh

chronos/chronos : tup/tup
	cd chronos ; tup

inotify-tools/libinotify-tools/src/scry : inotify-tools/src/inotifywait
	cd inotify-tools/libinotifytools/src ; gcc -I. *.o example.c -o scry

inotify-tools/src/inotifywait :
	cd inotify-tools ; ./autogen.sh ; ./configure ; make
