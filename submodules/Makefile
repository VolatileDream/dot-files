
all : tup chronos bloom-filter no-tup
go-build: age gron
no-tup : zzzcron rel roll-dice lookup pick scry extruder ondir go-build

.PHONY: all no-tup
.PHONY: tup chronos scry zzzcron roll-dice bloom-filter lookup pick 

tup :
	cd tup ; if [ ! -e ./tup ]; then ./bootstrap.sh ; else ./tup ; fi

age : age/age

age/age :
	cd age ; go build -o . filippo.io/age/cmd/...

bloom-filter : tup
	cd bloom-filter ; tup

count-distinct : tup
	cd count-distinct ; tup

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

extruder : extruder/extruder

extruder/extruder :
	cd extruder ; git submodule init ; git submodule update
	cd extruder ; make

ondir : ondir/ondir

ondir/ondir :
	cd ondir ; make

roll-dice : python3-virtual-env
	echo "source python3-virtual-env/bin/activate; \
		pip install -r roll-dice/requirements.txt;" | bash

zzzcron : python3-virtual-env
	# ahahahahah, ew. ;-;
	echo "source python3-virtual-env/bin/activate; \
		pip install -r zzzcron/requirements.txt; \
		pip install --editable zzzcron" | bash

python3-virtual-env : 
	virtualenv -p python3 python3-virtual-env
	echo "source python3-virtual-env/bin/activate; \
    pip install tdigest" | bash

