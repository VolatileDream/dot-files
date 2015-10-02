
all : tup chronos bloom-filter no-tup
no-tup : zzzcron rel roll-dice lookup pick scry extruder http2sh

.PHONY: all no-tup
.PHONY: tup chronos scry zzzcron roll-dice bloom-filter lookup pick http2sh

tup :
	cd tup ; if [ ! -e ./tup ]; then ./bootstrap.sh ; else ./tup ; fi

bloom-filter : tup
	cd bloom-filter ; tup

chronos : tup
	cd chronos ; tup

lookup :
	cd lookup ; make

pick :
	cd pick ; if [ ! -e Makefile ]; then ./autogen.sh ; ./configure ; fi ; make

scry : inotify-tools/libinotify-tools/src/scry

inotify-tools/libinotify-tools/src/scry : inotify-tools/src/inotifywait
	cd inotify-tools/libinotifytools/src ; gcc -I. *.o example.c -o scry

inotify-tools/src/inotifywait :
	cd inotify-tools ; if [ ! -e Makefile ]; then ./autogen.sh ; ./configure ; fi ; make

extruder : extruder/extruder

extruder/extruder :
	cd extruder ; git submodule init ; git submodule update
	cd extruder ; make

rel : python2-virtual-env
	echo "source python2-virtual-env/bin/activate; \
		pip install -r rel/requirements.txt;  \
		pip install --editable rel" | bash

http2sh : python3-virtual-env
	echo "source python3-virtual-env/bin/activate; \
		pip install -r http2sh/requirements.txt;" | bash

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

python2-virtual-env : 
	virtualenv -p python2 python2-virtual-env

