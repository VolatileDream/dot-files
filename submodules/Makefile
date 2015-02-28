
all : tup chronos scry zzzcron roll-dice bloom-filter
.PHONY: tup chronos scry zzzcron roll-dice bloom-filter

scry : inotify-tools/libinotify-tools/src/scry

roll-dice : python-virtual-env
	echo "source python-virtual-env/bin/activate; \
		pip install -r roll-dice/requirements.txt;" | bash

zzzcron : python-virtual-env
	# ahahahahah, ew. ;-;
	echo "source python-virtual-env/bin/activate; \
		pip install -r zzzcron/requirements.txt; \
		pip install --editable zzzcron" | bash

bloom-filter :
	cd bloom-filter ; make

tup :
	cd tup ; if [ ! -e ./tup ]; then ./bootstrap.sh ; else ./tup ; fi

chronos : tup
	cd chronos ; tup

inotify-tools/libinotify-tools/src/scry : inotify-tools/src/inotifywait
	cd inotify-tools/libinotifytools/src ; gcc -I. *.o example.c -o scry

inotify-tools/src/inotifywait :
	cd inotify-tools ; ./autogen.sh ; ./configure ; make

python-virtual-env : 
	virtualenv -p python3 python-virtual-env
