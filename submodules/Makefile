
all : tup/tup chronos/chronos

tup/tup : 
	cd tup ; ./bootstrap.sh

chronos/chronos : tup/tup
	cd chronos ; tup

