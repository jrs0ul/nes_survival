all:
	ca65 src/game.asm -g -o src/game.o
	ld65 -o survival.nes -C memory.cfg src/game.o --dbgfile survival.dbg -Ln survival.labels.txt
	rm -rf src/*.o
	python fceux_symbols.py
