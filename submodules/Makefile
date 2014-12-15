
all : tup chronos scry zzzcron
.PHONY: tup chronos scry zzzcron

tup : tup/tup
chronos : chronos/chronos
scry : inotify-tools/libinotify-tools/src/scry

zzzcron : python-virtual-env
	# ahahahahah, ew. ;-;
	echo "source python-virtual-env/bin/activate; \
		pip install -r zzzcron/requirements.txt; \
		pip install --editable zzzcron" | bash

tup/tup : 
	cd tup ; ./bootstrap.sh

chronos/chronos : tup/tup
	cd chronos ; tup

inotify-tools/libinotify-tools/src/scry : inotify-tools/src/inotifywait
	cd inotify-tools/libinotifytools/src ; gcc -I. *.o example.c -o scry

inotify-tools/src/inotifywait :
	cd inotify-tools ; ./autogen.sh ; ./configure ; make

python-virtual-env : 
	virtualenv -p python3 python-virtual-env
