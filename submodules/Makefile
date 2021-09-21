
all : tup chronos no-tup
go-build: age gron
no-tup : zzzcron rel lookup pick scry ondir go-build

.PHONY: all no-tup
.PHONY: tup chronos scry zzzcron lookup pick 

tup :
	cd tup ; if [ ! -e ./tup ]; then ./bootstrap.sh ; else ./tup ; fi

age : age/age

age/age :
	cd age ; go build -o . filippo.io/age/cmd/...

chronos : tup
	cd chronos ; tup

gron : gron/gron

gron/gron :
	cd gron ; go build -o . github.com/tomnomnom/gron

lookup :
	cd lookup ; make

pick :
	cd pick ; if [ ! -e Makefile ]; then ./configure ; fi ; make

scry : inotify-tools/libinotify-tools/src/scry

inotify-tools/libinotify-tools/src/scry : inotify-tools/src/inotifywait
	cd inotify-tools/libinotifytools/src ; gcc -I. *.o example.c -o scry

inotify-tools/src/inotifywait :
	cd inotify-tools ; if [ ! -e Makefile ]; then ./autogen.sh ; ./configure ; fi ; make

ondir : ondir/ondir

ondir/ondir :
	cd ondir ; make

zzzcron : python3-virtual-env
	# ahahahahah, ew. ;-;
	echo "source python3-virtual-env/bin/activate; \
		pip install -r zzzcron/requirements.txt; \
		pip install --editable zzzcron" | bash

python3-virtual-env : 
	virtualenv -p python3 python3-virtual-env

