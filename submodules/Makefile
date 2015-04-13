
all : tup chronos bloom-filter no-tup
no-tup : zzzcron roll-dice lookup pick scry

.PHONY: all no-tup
.PHONY: tup chronos scry zzzcron roll-dice bloom-filter lookup pick

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

roll-dice : python-virtual-env
	echo "source python-virtual-env/bin/activate; \
		pip install -r roll-dice/requirements.txt;" | bash

zzzcron : python-virtual-env
	# ahahahahah, ew. ;-;
	echo "source python-virtual-env/bin/activate; \
		pip install -r zzzcron/requirements.txt; \
		pip install --editable zzzcron" | bash

python-virtual-env : 
	virtualenv -p python3 python-virtual-env

