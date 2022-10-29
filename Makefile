all:
	ca65 game.asm -g -o game.o
	ld65 -o survival.nes -C memory.cfg game.o --dbgfile survival.dbg -Ln survival.labels.txt
	rm -rf *.o
	python fceux_symbols.py
